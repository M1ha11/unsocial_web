Rails.application.routes.draw do
  devise_for :users, path: '/', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  resources :users, only: [:show] do
    resources :albums do
      resources :photos do
        resources :comments
      end
    end
    member do
      get :following, :followers
    end
  end
  resources :interrelationships, only: [:create, :destroy]
  root 'home_page#index'
end
