Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :works
  get 'home/:type', to: 'home#index'
  post 'home/:type', to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
