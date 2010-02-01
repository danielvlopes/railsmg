module MeetingsHelper
  
  def meeting_attachments(meeting)
    output = []
    output << link_to("CODE", meeting.code, :popup => true)   if meeting.code.present?
    output << link_to("VÍDEO", meeting.video, :popup => true) if meeting.video.present?
    output << link_to("SLIDES", meeting.slides, :popup => true) if meeting.slides.present?
    
    (output.present?) ? output.join(",").html_safe! : "Não disponível"
  end
  
end