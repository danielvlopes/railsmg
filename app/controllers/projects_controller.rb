class ProjectsController < ApplicationController
  def index
    @users = User.active.with_projects
  end
end

