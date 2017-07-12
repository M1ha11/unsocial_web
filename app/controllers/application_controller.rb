require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html, :js

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, :only => [:index]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :adress, :avatar, :avatar_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :adress, :avatar, :avatar_cache, :remove_avatar])
  end
end
