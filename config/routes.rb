Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :works
  resources :users
  resources :settings
  resources :messages
  get 'home/:type', to: 'home#index'
  post 'home/:type', to: 'home#index'
  post 'unbookmark/:id', to: 'works#unbookmark'
  get '/users/:id/follow', to: 'users#follow'
  get '/users/:id/message', to: 'users#message'
  get '/users/:id/:colour', to: 'users#update'
  get '/messages/:id/mark_read', to: 'messages#mark_read'
  get '/messages/:id/destroy', to: 'messages#destroy'
end
