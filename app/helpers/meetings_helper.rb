module MeetingsHelper
  def meeting_attachments(meeting)
    attachments = []
    attachments << link_to("CODE", meeting.code, :popup => true) if meeting.code?
    attachments << link_to("VÍDEO", meeting.video, :popup => true) if meeting.video?
    attachments << link_to("SLIDES", meeting.slides, :popup => true) if meeting.slides?
    
    attachments.empty? ? "Não disponível" : attachments.to_sentence.html_safe
  end
end
