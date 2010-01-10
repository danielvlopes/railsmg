class Notifier < ActionMailer::Base
  def signup_confirmation user
    recipients user.email_with_name
    subject    'RailsMG # Confirmação de conta'
    from       'donotreply@railsmg.com.br'
    body       :user => user
  end
end