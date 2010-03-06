class ProjectsController < ApplicationController
  menu_item :projects
  
  def index
    @users = User.active.with_projects
  end
end

