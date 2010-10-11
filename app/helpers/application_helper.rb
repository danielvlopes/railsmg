module ApplicationHelper
  def link_to_sponsor(name, url)
    link_to image_tag("sponsors/#{name.downcase}.jpg", :alt => name), url, :popup => true
  end
  
  def link_to_advertise
    mail_to('contato@railsmg.org', image_tag('sponsors/default.jpg', :alt => 'Anuncie aqui'), :encode => :javascript).html_safe
  end
  
  def gravatar_image_tag(email)
    digest = Digest::MD5.hexdigest(email)
    default = CGI.escape(request.protocol + request.host_with_port + image_path('gravatar.jpg'))

    image_tag("http://www.gravatar.com/avatar/#{digest}?size=48&default=#{default}", :alt => 'Gravatar')
  end

  def google_analytics
    render 'shared/analytics' if Rails.env.production?
  end
end
