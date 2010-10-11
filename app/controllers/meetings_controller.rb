class MeetingsController < BaseController
  def index
    @next_meetings = Meeting.next
    @last_meetings = Meeting.past
  end
end

