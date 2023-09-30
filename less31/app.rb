require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "sqlite3"

#set :database, "sqlite3:pizzashop.db"

configure :default do 
	set :database, 
	{adapter: "sqlite3",  
		#encoding: "unicode", 
		database: "pizzashop.db", 
		pool: 2
		# username: "your_username", 
		# password: "your_password"
	}
end

configure :development do 
	set :database, 
	{adapter: "sqlite3",  
		#encoding: "unicode", 
		database: "pizzashop.db", 
		pool: 2
		# username: "your_username", 
		# password: "your_password"
	}
end

configure :production do 
	set :database, 
	{adapter: "sqlite3",  
		#encoding: "unicode", 
		database: "pizzashop.db", 
		pool: 2
		# username: "your_username", 
		# password: "your_password"
	}
end

class Product < ActiveRecord::Base
	belongs_to :order_details
end

class Order < ActiveRecord::Base
	has_many :order_details
end

class OrderDetail < ActiveRecord::Base
	belongs_to :orders
	belongs_to :products
end

class FullOrderDetail < ActiveRecord::Base

end

def parse strin
	arr_order_products = strin.split(',')
	hh_orders = {}
	
	pizza_id = 0
	pizza_qty = 0

	arr_order_products.each do |item|
		pizza_id = item.split('=')[0].split('_')[1].chomp.to_i
		pizza_qty = item.split('=')[1]
		hh_orders[pizza_id] = pizza_qty
	end

	return hh_orders
end

get '/' do
	@products = Product.all
	erb :index
end

get '/about' do
	erb :about
end	

get '/menu' do
	erb :menu
end

get '/orders' do
		@full_order_details = FullOrderDetail.all
	erb :orders
end

get '/cart' do
	#@txt_cart_products = params[:orders]
	
	erb :cart
end

post '/cart' do
	@txt_cart_products = params[:orders]
	@hh_orders = parse @txt_cart_products
	@pizza = Product.all

	if @hh_orders.empty?
		return erb :cart_is_empty
	end

	# @arr_order_products = @txt_cart_products.split(',')
	
	# pizza_id = 0

	# @arr_order_products.each do |item|
	# 	pizza_id = item.split('=')[0].split('_')[1].chomp.to_i
	# 	pizza_qty = item.split('=')[1]
	# 	@hh_orders[pizza_id] = pizza_qty

	# end

	@text_hh = ''
	@hh_orders.each do |key,value|
		@text_hh += "#{key}=#{value},"
	end

  erb :cart
end

post '/order' do

	order = Order.create params[:client]

	@hh_final = {}
	final_order = params[:final_order]
	arr_final = final_order.split(',')

	arr_final.each do |item|
		pizza_id = item.split('=')[0].to_i
		pizza_qty = item.split('=')[1].to_i
		@hh_final[pizza_id] = pizza_qty
	end

	@hh_final.each do |key,value|
		order_details = OrderDetail.new :order_id => order.id, :product_id => key.to_i, :qty => value.to_i
		order_details.save
	end

	#redirect to '/'
	erb "Your order is having"
end