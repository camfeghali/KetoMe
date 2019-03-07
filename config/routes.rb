Rails.application.routes.draw do

  put '/meals/search', to: 'meals#recipe_name', as: 'search'

  resources :meal_ingredients
  resources :ingredients
  resources :meals
  resources :users, only: [:show, :new, :create, :destroy]

  # root 'application#home'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#delete', as: 'logout'


end
