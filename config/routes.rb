Rails.application.routes.draw do
  post 'follow/:id', to: 'relationships#create', as: 'follow'
  post 'unfollow/:id', to: 'relationships#destroy', as: 'unfollow'

  root 'home#index'

  devise_for :users

  resources :users, only: [:show] do
    get :following, :followers
  end
end
