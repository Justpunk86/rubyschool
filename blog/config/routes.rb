Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get '/' => 'home#index'
  #get 'home/index'
  #get '/contacts' => 'contacts#index'
  #post '/contacts' => 'contacts#create'
  #get '/contacts/new' => 'contacts#new'
  get '/about' => 'about#about'
  get '/terms' => 'terms#terms'
  resource :contacts, only: [:new, :create], path_names: { :new => '' }
  #get '/articles' => 'articles#index'
  resources :articles  do
    resources :comments, only: [:create, :edit, :delete]
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
