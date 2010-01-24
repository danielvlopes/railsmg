class UsersController < ApplicationController
  load_and_authorize_resource  
  inherit_resources
  current_tab :users
  
  def create
    create! do |success, failure|
      success.html { render 'success' }
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    update!
  end
  
  protected
  
  def collection
    @users ||= User.active.all
  end
end

