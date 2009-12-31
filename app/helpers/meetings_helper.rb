module MeetingsHelper
  def content_links meeting
    meeting.content.collect do |content|
      link_to h(content), content.url, :popup => true
    end.to_sentence
  end
end

