class HomeController < ApplicationController
  def index
    @next_meeting = Meeting.next(Date.today).first
  end
end

