class ApplicationController < ActionController::Base
  before_acition :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :user_area, :curriculum])
  end
end
