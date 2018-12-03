Rails.application.routes.draw do
  get 'search', to: 'pages#search'
  resources :books
  resources :comments
  resources :posts
  resources :users
  root 'pages#home'
end
