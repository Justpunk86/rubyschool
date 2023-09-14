require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
require "sqlite3"


#set :database, "sqlite3:barbershop"

configure :default do 
	set :database, 
	{adapter: "sqlite3",  
		#encoding: "unicode", 
		database: "barbershop.db", 
		pool: 2
		# username: "your_username", 
		# password: "your_password"
	}
end

configure :development do 
	set :database, 
	{adapter: "sqlite3",  
		#encoding: "unicode", 
		database: "barbershop.db", 
		pool: 2
		# username: "your_username", 
		# password: "your_password"
	}
end

configure :production do
  set :database, 
  {adapter: "sqlite3",  
  	#encoding: "unicode", 
  	database: "barbershop.db", 
  	pool: 2
  	# username: "your_username", 
  	# password: "your_password"
  }
end

class Client < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 3}
  validates :phone, presence: true
  validates :datestamp, presence: true
  validates :color, presence: true
end

class Barber < ActiveRecord::Base

end

class Contact < ActiveRecord::Base

end

# db_config = YAML.load_file("database.yml")
# ActiveRecord::Base.establish_connection(
# 	db_config[ENV['RACK_ENV']]
# 	)

get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index
end

get '/visit' do
	@barbers = Barber.order "created_at DESC"
  @c = Client.new
  
  erb :visit
end

post '/visit' do

  @barbers = Barber.order "created_at DESC"

  @c = Client.new params[:client]
  if @c.save
    erb "<h2>Sank you, you are check visit log.</h2>"
  else
    @error = @c.errors.full_messages.first
    erb :visit
  end

  #redirect to '/visit'
    
end

get '/contacts' do
	@contacts = Contact.order "created_at DESC"
  erb :contacts
end

post '/contacts' do
  @c = Contact.new params[:contact]#:mail => @email, :content => @content
  @c.save

  redirect to '/contacts'
end

get '/showusers' do
	@clients = Client.order "created_at DESC"
  erb :showusers
end

get '/barber/:id' do
  @barber = Barber.find(params['id'])
  erb :barber
end

get '/client/:id' do
  @client = Client.find(params['id'])
  erb :client
end