require "rubygems"
require "sinatra"
require "sinatra/reloader"
require 'sinatra/activerecord'
require 'sqlite3'

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

class Post < ActiveRecord::Base
	has_many :comments
end

class Comment < ActiveRecord::Base
	belongs_to :post
end

get '/' do
	erb :index
end

get '/posts' do
	@p = Post.order "created_at ASC"
  erb :posts
end

get '/new_post' do
	
  erb :new_post
end

post '/new_post' do
	p = Post.new params[:post]
	p.save
  erb :new_post
end

get '/post/:id' do
	@p = Post.find params[:id]
	@c = Comment.where(post_id: @p.id)
	@c.order "created_at ASC"
  erb :post
end

post '/post/:id' do
	@p = Post.find params[:id]
	@c = Comment.order "created_at ASC"
	c = Comment.new params[:comment]
	c.post_id = params[:id]
	c.save
  erb :post
end

get '/new_comment/:id' do
	@p = Post.find params[:id]
	@c = Comment.new params[:comment]
  erb :new_comment
end

post '/new_comment/:id' do
	@p = Post.find params[:id]
	c = Comment.new params[:comment]
	c.post_id = params[:id]
	c.save
  redirect to "/post/#{params[:id]}"
end

post '/del/:id' do
	@c = Comment.find params[:id]
	@c.delete
	@c.save
	session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
	#redirect to "/post/#{@c[:post_id]}"
end

get '/comments' do
	@p = Post.order "created_at ASC"
	@c = Comment.order "created_at ASC"
  erb :comments
end