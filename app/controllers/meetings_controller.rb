class MeetingsController < ApplicationController
  load_and_authorize_resource  
  inherit_resources
  current_tab :meetings
  
  def index
    @next_meeting = Meeting.next
    @last_meetings = Meeting.past
  end
end

