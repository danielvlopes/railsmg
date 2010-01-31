class HomeController < ApplicationController
  current_tab :home
  
  def index
    @next_meeting = Meeting.next(Date.today).first
  end
end

