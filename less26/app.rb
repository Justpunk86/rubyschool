require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'

configure do
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end

before '/secure/*' do
  unless session[:identity]
    session[:previous_url] = request.path
    @error = 'Sorry, you need to be logged in to visit ' + request.path
    halt erb(:login_form)
  end
end

get '/' do
  erb 'Can you handle a <a href="/secure/place">secret</a>?'
end

get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get '/secure/place' do
  erb 'This is a secret place that only <%=session[:identity]%> has access to!'
end

def put_file hh
  file = File.open hh[:fname], hh[:type]
  file.write hh[:row]
  file.close
  redirect to hh[:red_to]
end

def put_db hh
  db = SQLite3::Database.open './db/barbershop.sqlite'
  
  db.execute hh[:dml_ex]
  db.close
  redirect to hh[:red_to]
end

get '/about' do
  @error = 'something wrong!'
  erb :about
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @hairdresser = params['hairdresser']
  @username = params['username']
  @phone = params['phone']
  @datetime = params['datetime']
  @color = params['color']

#хэш

  hhe = { :hairdresser => 'Выбирите парикмахера',
          :username => 'Введите имя',
          :phone => 'Введите телефон',
          :datetime => 'Введите дату и время'
          }
=begin          
#для каждой пары ключ-значение
hhe.each do |key,value|
  #если параметр пустой
  if params[key] == ''
    #переменной еррор присвоить значение хеша
    @error = hhe[key]
    #вернуть представление визит
    return erb:visit
  end
=end

@error = hhe.select {|key,_| params[key] == ""}.values.join(",")

if @error != ''
  return erb:visit
end

#end
dml = "insert into users(name,phone,datestamp,barber,color)
      values('#{@name}', 
              '#{@phone}', 
              '#{@datetime}', 
              '#{@hairdresser}', 
              '#{@color}');"

  #str = "Hairdresser: #{@hairdresser}, " +
  #        "Name: #{@username}, " +
  #        "Telephone: #{@phone}, " +
  #        "Date and dimte: #{@datetime}\n"

  red_to = '/visit'

  #put_file :fname => "./public/users.txt", 
  #          :type =>'a', 
  #          :row => str,
  #          :red_to => red_to

  put_db :dml_ex => dml, :red_to => red_to
    
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @email = params['mail']
  @text = params['text']

  #str = "Email: #{@email}, " +
  #  "Message: #{@text} \n"

  dml = "insert into contacts(email,message)
      values('#{@email}', '#{@text}');"

  red_to = '/contacts'

  put_db :dml_ex => dml, :red_to => red_to

 # Pony.mail(:to => "ermachkovsavictory12@gmail.com",
  #          :from => "#{@email}",
   #         :subject => "ruby school less24 hw",
    #        :body => "#{@text}")

  #put_file :fname => "./public/contacts.txt", 
  #          :type => 'a', 
  #          :row => str,
  #          :red_to => red_to


end
