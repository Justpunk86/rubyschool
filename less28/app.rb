require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def initdb 
  @db = SQLite3::Database.new 'leprosorium.db'
  @db.results_as_hash = true
end

before do
  initdb
end

configure do
  initdb
  @db.execute 'create table if not exists 
  posts
  (
    id integer primary key autoincrement,
    created_date date,
    content text
  )'
end

get '/' do
  erb "Hello!"
end  

get '/new' do
  erb :new
end

post '/new' do
  @content = params[:content]
  

  if @content.length <= 0
    @error = 'Type post text'
    return erb :new
  end

  @db.execute 'insert into posts 
  (content, created_date)
  values (?, datetime())',
  [@content]

  erb "You typed #{@content}"
end  