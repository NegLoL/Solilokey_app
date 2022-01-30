Rails.application.routes.draw do
  resources :users

  get '/' => "home#top"
  get "/about" => "home#about"

  #名前付きルート使える
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
