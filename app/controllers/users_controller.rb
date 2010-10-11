class UsersController < ApplicationController
  load_and_authorize_resource
  inherit_resources

  respond_to :html, :xml, :json

  def create
    create! do |success, failure|
      success.html { render 'success' }
    end
  end

  def edit
  end

  def update
    resource.admin = params[:user][:admin] == '1' if current_user.admin?
    update!
  end

  def activate
    user = User.active! params[:perishable_token]
    UserSession.create(user)

    redirect_to current_user
  end

protected

  def collection
    @users ||= User.active.all
  end
end

