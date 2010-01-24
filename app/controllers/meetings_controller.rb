class MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
    @last_meeting = @meetings.first
  end
end

