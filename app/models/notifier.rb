class Notifier < ActionMailer::Base
  layout "mailer"
  
  def signup_confirmation user
    recipients user.email_with_name
    subject    "#{APP_CONFIG[:name]} - confirmação de cadastro"
    from       APP_CONFIG[:noreply_email]
    body       :user => user
  end
end
