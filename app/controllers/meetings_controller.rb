class MeetingsController < ApplicationController
  load_and_authorize_resource  
  inherit_resources
  current_tab :meetings
  
  def index
    @next_meeting = Meeting.first
    @last_meetings = Meeting.all(:conditions=>["id <> ?", @next_meeting.id]) if @next_meeting.present?
  end
end

