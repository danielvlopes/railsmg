class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.with_content
    @last_meeting = @meetings.first
  end
end

