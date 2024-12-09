class UserMailer < ApplicationMailer
  def welcome_email(user_mail, message, body_message)
    mail(to: user_mail, subject: 'Message from Chatapi', body: body_message)
  end
end
