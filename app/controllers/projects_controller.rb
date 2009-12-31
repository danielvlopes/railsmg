class ProjectsController < ApplicationController
  def index
    @users = User.with_project.all
  end
end

