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
    content text,
    author text
  )'
  @db.execute 'create table if not exists 
  comments
  (
    id integer primary key autoincrement,
    created_date date,
    content text,
    post_id integer
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
  @author = params[:author]

  hh = {
    :content => 'Введите текст поста',
    :author => 'Введите имя автора'
  }

  @error = hh.select { |key,_| params[key] == "" }.values.join(",")

  if @error != ''
    return erb :new
  end

  @db.execute 'insert into posts 
  (content, author, created_date)
  values (?, ?, datetime())',
  [@content], [@author]

  redirect to '/'

  erb "You typed #{@content}"
end  

# вывод инфо о посте

get '/comments/:post_id' do
#получаем переменную из url`a
  post_id = params[:post_id]

#получаем данные для поста
  results = @db.execute 'select * from posts where id = ?', [post_id]
  @row = results[0]

#выбираем комментарии для поста
  @comments = @db.execute 'select * from comments where post_id = ? order by id', [post_id]

#возвращаем представление commetns.erb
  erb :comments
  #erb "#{post_id} comments"
end

post '/comments/:post_id' do
  post_id = params[:post_id]

  content = params[:content]

  @db.execute 'insert into comments 
  (
    content, post_id, created_date
  )
  values (
    ?, 
    ?, 
    datetime()
    )', [content], [post_id]

  erb "You typed comment '#{content}' for post #{post_id}"
  redirect to ('/comments/' + post_id)
end