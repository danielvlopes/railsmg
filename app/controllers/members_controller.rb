class MembersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id], :include=>:projects)
  end
end

