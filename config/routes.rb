Rails.application.routes.draw do
  devise_for :users, path: 'devise/', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  root 'home_page#index'
end
