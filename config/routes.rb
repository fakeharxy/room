Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :works
  get 'home/:type', to: 'home#index'
  post 'home/:type', to: 'home#index'
  post 'unbookmark/:id', to: 'works#unbookmark'
end
