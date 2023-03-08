Rails.application.routes.draw do
  devise_for :users 
  
  root to:"user/conta#index" 

  resources :translations do
    get 'deposit', on: :new
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
