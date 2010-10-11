class MeetingsController < ApplicationController
  load_and_authorize_resource  
  inherit_resources
  
  def index
    @next_meetings = Meeting.next
    @last_meetings = Meeting.past
  end
end

