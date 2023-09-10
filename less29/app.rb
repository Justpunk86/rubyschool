require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "sinatra-activerecord"

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	
end

get '/' do
	erb 'Wellcom to Sinatra-Bootstrap Clean Template!'
end
