class HomePageController < ApplicationController
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def index
  end

  def home
  end

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  # end
end