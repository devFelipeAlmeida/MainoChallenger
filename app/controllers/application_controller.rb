class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale_from_session

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
    redirect_back(fallback_location: root_path)
  end

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :full_name])
  devise_parameter_sanitizer.permit(:account_update, keys: [:username, :full_name, :profile_pic, :bio])
end

private

def set_locale_from_session
  I18n.locale = session[:locale] || I18n.default_locale
end
end