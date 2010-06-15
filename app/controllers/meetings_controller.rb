class MeetingsController < ApplicationController
  load_and_authorize_resource  
  inherit_resources
  menu_item :meetings
  
  def index
    @next_meetings = Meeting.next(Date.today)
    @last_meetings = Meeting.past(Date.today)
  end
end

