Rails.application.routes.draw do
  root 'home#index'
  post 'follow/:id', to: 'relationships#follow', as: 'follow'
  post 'unfollow/:id', to: 'relationships#unfollow', as: 'unfollow'
  get 'timeline', to: 'posts#timeline'
  devise_for :users, :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}
  resources :users, only: [:show, :edit, :update, :create] do
    resources :likes, only: [:show]
    get :following, :followers
    member do
      get :health
    end
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy, :index]
  end
end
