Rails.application.routes.draw do
  #get '/' => 'home#index'
  get 'home/index'
  #get '/contacts' => 'contacts#index'
  #post '/contacts' => 'contacts#create'
  #get '/contacts/new' => 'contacts#new'

  resource :contacts, only: [:new, :create], path_names: { :new => '' }
  get '/articles' => 'articles#create'
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
