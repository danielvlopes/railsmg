module ApplicationHelper
  def gravatar_image_tag email
    email = Digest::MD5.hexdigest(email)
    default = CGI.escape(request.protocol + request.host_with_port + image_path('gravatar.jpg'))

    image_tag "http://www.gravatar.com/avatar/#{email}?size=48&default=#{default}", :alt => 'Gravatar'
  end

  def google_analytics
    render :partial => 'shared/analytics' if Rails.env == 'production'
  end

end
