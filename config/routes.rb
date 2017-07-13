Rails.application.routes.draw do
  devise_for :users, path: '/', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  ActiveAdmin.routes(self)

  root 'home_page#index'

  resources :users, only: [:show] do
    resources :albums, except: [:index] do
      resources :photos, except: [:index] do
        resources :comments, only: [:create, :destroy]
      end
    end
    member do
      get :following, :followers
    end
  end

  resources :interrelationships, only: [:create, :destroy]

  get 'search', to: 'search#search', autocomplete: true
  get 'tag_search', to: 'search#tag_search', autocomplete: true

  mount ActionCable.server => '/cable'
end
