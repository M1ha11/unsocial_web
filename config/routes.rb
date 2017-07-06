Rails.application.routes.draw do

  get 'search', to: 'search#search', autocomplete: true


  mount ActionCable.server => '/cable'

  devise_for :users, path: '/', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }

  resources :users, only: [:show] do
    resources :albums do
      resources :photos do
        resources :comments, only: [:create, :destroy]
      end
    end
    member do
      get :following, :followers
    end
  end

  resources :interrelationships, only: [:create, :destroy]
  root 'home_page#index'
end
