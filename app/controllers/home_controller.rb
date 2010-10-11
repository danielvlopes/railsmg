class HomeController < ApplicationController
  def index
    @next_meeting = Meeting.next.first
  end
end

