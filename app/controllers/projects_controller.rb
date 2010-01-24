class ProjectsController < ApplicationController
  current_tab :projects
  
  def index
    @users = User.active.with_projects
  end
end

