class MeetingsController < ApplicationController
  load_and_authorize_resource  
  inherit_resources
  current_tab :meetings
  
  def index
    @next_meeting = Meeting.next(Date.today).first
    @last_meetings = Meeting.past(Date.today)
  end
end

