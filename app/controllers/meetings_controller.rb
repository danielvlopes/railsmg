class MeetingsController < ApplicationController
  load_and_authorize_resource  
  inherit_resources
  
  def index
    @meetings = Meeting.all
    @last_meeting = @meetings.first
  end
end

