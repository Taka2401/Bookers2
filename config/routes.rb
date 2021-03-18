Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:new, :create, :edit, :update, :index, :show]

end
