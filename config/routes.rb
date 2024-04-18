Rails.application.routes.draw do
  get 'users/show'
  resources :posts
  devise_for :users

  resources :users, only: [:show]

  root to: 'home#index'

  post "toggle_like", to: "likes#toggle_like", as: :toggle_like

  resources :comments, only: [:create, :destroy]
end
