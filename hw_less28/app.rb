require 'rubygems'
require 'sinatra'
require 'sqlite3'
require 'sinatra/reloader'

def init_db
  @db = SQLite3::Database.new 'lepra.db'
  @db.results_as_hash = true
end

before do
  init_db
end

configure do
  init_db

  @db.execute 'create table if not exists posts
      (
        id integer primary key autoincrement,
        content text,
        author text,
        date_created date
      )'
  @db.execute 'create table if not exists comments
      (
        id integer primary key autoincrement,
        content text,
        author text,
        post_id integer,
        date_created text
      )'
  @db.close
end


get '/' do
  redirect to '/index'
end

get '/index' do
  @posts = @db.execute 'select * from posts order by id asc limit 3 '
  erb :index
end

get '/posts' do
  @posts = @db.execute 'select * from posts order by id desc'

  erb :posts
end

post '/posts' do
  post_id = params[:btn_delete]
  @db.execute 'delete from posts where id = ?', [post_id]
  redirect to '/posts'
end

get '/comments/:id' do
  post_id = params[:id]
   result= @db.execute 'select * from posts where id = ?', [post_id]
   @post_data = result[0]

   @comments = @db.execute 'select * from comments where post_id = ?', [post_id]

  erb :comments
end


post '/comments/:id' do
  post_id = params[:id]

  @author = params[:author]
  @content = params[:content]

  @db.execute 'insert into comments (author, content, post_id, date_created)
        values(?,?,?,datetime())', [@author], [@content], [post_id]

  redirect to "/comments/#{post_id}" 
end

get '/new' do
  erb :new
end

post '/new' do
  @author = params[:author]
  @content = params[:content]

  hh = {
      :author => 'Enter author name',
      :content => 'Enter content text'
  }

  @error = hh.select {|key,_| params[key] == ""}.values.join(", ")

  if @error != ''
    return erb :new
  end

  #init_db
  @db.execute 'insert into posts(author, content, date_created)
        values(?,?,datetime())',
        [@author], [@content]

  redirect to '/posts'

  #@db.close
end

