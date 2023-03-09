Rails.application.routes.draw do
  devise_for :users 
  
  root to:"user#index" 

  resources :user

  resources :translations do
    get 'deposit', on: :new
    get 'withdraw', on: :new
    get 'transfer', on: :new
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
