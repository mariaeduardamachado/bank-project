Rails.application.routes.draw do
  devise_for :users
  root to:"user/conta#index"
  namespace :user do 
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
