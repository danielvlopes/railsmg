class HomeController < ApplicationController
  current_tab :home
  
  def index
    @next_meeting = Meeting.next(Date.today)
  end
end

