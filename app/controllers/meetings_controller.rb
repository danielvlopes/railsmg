class MeetingsController < ApplicationController
  load_and_authorize_resource  
  inherit_resources
  
  def index
    @next_meetings = Meeting.next(Date.today)
    @last_meetings = Meeting.past(Date.today)
  end
end

