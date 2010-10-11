class MeetingsController < BaseController
  def index
    @next_meetings = Meeting.next.most_recent
    @last_meetings = Meeting.past.most_recent
  end
end

