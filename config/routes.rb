Rails.application.routes.draw do
  post 'follow/:id', to: 'relationships#create', as: 'follow'
  post 'unfollow/:id', to: 'relationships#destroy', as: 'unfollow'

  root 'home#index'

  devise_for :users

  resources :users, only: [:show, :edit, :update, :create] do
    resources :likes, only: [:show]
    get :following, :followers
  end

  resources :posts do
    resources :likes, only: [:create, :destroy, :index]
  end

end
