Rails.application.routes.draw do
  root 'sessions#new'
  get '/archive',       to: 'orders#archive', as: 'archive'
  get '/login',         to: 'sessions#new', as: 'login'
  post '/login',        to: 'sessions#create'
  get '/logout',        to: 'sessions#destroy', as: 'logout'
  get '/agenda(/:date)',  to: 'agenda#index', as: 'agenda'
  resources :orders do
    resources :tasks
  end
  resources :halls
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
