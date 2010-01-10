class UsersController < ApplicationController
  access_control do
    deny anonymous, :to => %w(edit update)
    allow all
  end
  
  inherit_resources
  
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

