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
  #db = get_db

  #@barbers = db.execute 'select name from barbers order by name asc;'
  #db.close
  erb :visit
end

post '/visit' do
  @barber = params['barber']
  @username = params['username']
  @phone = params['phone']
  @datetime = params['datetime']
  @color = params['color']

  @barbers = Barber.order "created_at DESC"
#хэш

  hhe = { :hairdresser => 'Выбирите парикмахера',
          :username => 'Введите имя',
          :phone => 'Введите телефон',
          :datetime => 'Введите дату и время'
          }

#для каждой пары ключ-значение
#если параметр пустой
#переменной еррор присвоить значение хеша
  @error = hhe.select {|key,_| params[key] == ""}.values.join(",")

#вернуть представление визит
  if @error != ''
    return erb:visit
  end

  #dml = "insert into users(name,phone,datestamp,barber,color)
  #      values(?,?,?,?,?);"
  #arr_values = [@username, @phone, @datetime, @barber, @color]

  c = Client.new :name => @username,
      :phone => @phone,
      :datestamp => @datetime,
      :barber => @barber,
      :color => @color
  c.save

  redirect to '/visit'

  #red_to = '/visit'

  #put_db :dml_ex => dml, :arr_val => arr_values, :red_to => red_to
    
end

get '/contacts' do
	@contacts = Contact.order "created_at DESC"
  erb :contacts
end

post '/contacts' do
  @email = params['mail']
  @content = params['content']

  contact = Contact.new :mail => @email, :content => @content
  contact.save

  redirect to '/contacts'

  #dml = "insert into contacts(email,message)
  #    values(?, ?);"
  #arr_values = [@email, @text]

  #red_to = '/contacts'

  #put_db :dml_ex => dml, :arr_val => arr_values, :red_to => red_to

 # Pony.mail(:to => "ermachkovsavictory12@gmail.com",
  #          :from => "#{@email}",
   #         :subject => "ruby school less24 hw",
    #        :body => "#{@text}")

end

get '/showusers' do
	@clients = Client.order "created_at DESC"

  #db = get_db

  #@users = db.execute 'select * from users'
  #db.close
  erb :showusers
end

post '/showusers' do


end
