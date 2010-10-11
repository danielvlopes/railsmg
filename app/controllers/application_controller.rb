class ApplicationController < ActionController::Base
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation

  helper_method :current_user, :signed_in?

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from CanCan::AccessDenied, :with => :access_denied
  
  before_filter :set_menu_item

  protected

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def signed_in?
    !!current_user
  end
  
  def set_menu_item
    @menu_item = controller_name
  end

  private

  def access_denied
    if signed_in?
      render 'shared/access_denied', :status => 401
    else
      redirect_to login_path
    end
  end

  def not_found
    render 'shared/not_found', :status => 404
  end
end