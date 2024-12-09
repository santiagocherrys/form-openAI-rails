class UserMailer < ApplicationMailer
  def welcome_email(user_mail, message)
    mail(to: user_mail, subject: 'Welcome to My Awesome App', body: message)
  end
end
