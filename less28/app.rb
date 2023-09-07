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

#configure вызывается каждый раз при конфигурации приложения:
#когда изменился код программы и перезагрузилась страница

configure do
  #инициализация таблицы
  initdb

  #создаёт таблицу если таблица не сущ-т
  @db.execute 'create table if not exists 
  posts
  (
    id integer primary key autoincrement,
    created_date date,
    content text
  )'
end

get '/' do

  #выбираем список постов из БД
  @results = @db.execute 'select * from posts order by id desc'

  erb :index
end  

# обработчик get-запроса /new
# (браузер получает страницу с сервера)
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