Rails.application.routes.draw do
  #get "signup" => 'users#new'
  #get "users/index" => "users#index"
  resources :users

  get '/' => "home#top"
  get "/about" => "home#about"
end
