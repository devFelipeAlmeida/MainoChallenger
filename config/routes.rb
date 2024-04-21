Rails.application.routes.draw do
  get 'users/show'
  resources :posts
  devise_for :users

  resources :users, only: [:show]

  root to: 'home#index'

  post "toggle_like", to: "likes#toggle_like", as: :toggle_like

  resources :comments, only: [:create, :destroy]
  resources :guest_comments, only: [:create, :destroy]

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"

  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get 'search_tags', to: "posts#search_tags"
end
