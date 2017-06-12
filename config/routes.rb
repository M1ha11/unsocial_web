Rails.application.routes.draw do
  devise_for :users, path: 'devise/', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  resources :users, only: [:show] do
    resources :albums do
      resources :photos
    end
  end
  root 'home_page#index'
end
