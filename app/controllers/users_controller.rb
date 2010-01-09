class UsersController < ApplicationController
  access_control do
    allow all, :except => %w(edit update)
    allow logged_in, :to => %w(edit update)
  end
  
  inherit_resources
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    update!
  end
end

