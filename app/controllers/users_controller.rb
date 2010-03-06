class UsersController < ApplicationController
  load_and_authorize_resource
  inherit_resources
  menu_item :users

  respond_to :html, :xml, :json

  def create
    create! do |success, failure|
      success.html { render 'success' }
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    @user.admin = true if current_user.admin? && params[:user][:admin].present?
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

