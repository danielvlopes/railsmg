class UsersController < ApplicationController
  access_control do
    deny anonymous, :to => %w(edit update)
    allow all
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

