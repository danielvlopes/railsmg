class ActiveUsersController < ApplicationController
  def active
    user = User.active! params[:perishable_token]
    UserSession.create(user)
    
    redirect_to current_user
  end
end
