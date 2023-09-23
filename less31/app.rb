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
	erb :menu
end