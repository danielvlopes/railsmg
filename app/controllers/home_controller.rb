class HomeController < ApplicationController
  menu_item :home
  
  def index
    @next_meeting = Meeting.next(Date.today).first
  end
end

