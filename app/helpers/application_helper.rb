module ApplicationHelper
  def gravatar_image_tag email, options = {}
    email = Digest::MD5.hexdigest(email)
    default = CGI.escape(request.protocol + request.host_with_port + image_path('gravatar.jpg'))

    image_tag "http://www.gravatar.com/avatar/#{email}?size=48&default=#{default}", options
  end
  
  def link_to_unless_active name, options = {}, html_options = {}
    # Members should be active into index and show
    if options == members_path
      active = controller.controller_name == 'members'
    else
      active = current_page?(options)
    end
    
    link_to_unless(active, name, options, html_options) do
      link_to name, options, html_options.merge(:class => 'active')
    end
  end
end

