class UserSessionsController < ApplicationController
  access_control do
    allow anonymous, :to => %w(new create)
    allow logged_in, :to => :destroy
  end
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    
    if @user_session.save
      redirect_to current_user
    else
      render :new
    end
  end
  
  def destroy
    current_user_session.destroy
    redirect_to root_path
  end
end
