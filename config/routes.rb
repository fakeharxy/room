Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :works
  resources :users
  resources :settings
  get 'home/:type', to: 'home#index'
  post 'home/:type', to: 'home#index'
  post 'unbookmark/:id', to: 'works#unbookmark'
  get '/users/:id/:colour', to: 'users#update'
end
