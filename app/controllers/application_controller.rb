class ApplicationController < ActionController::Base
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation

  helper_method :current_user, :signed_in?

  rescue_from Acl9::AccessDenied, :with => :access_denied
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  protected

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def signed_in?
    current_user ? true : false
  end
end

