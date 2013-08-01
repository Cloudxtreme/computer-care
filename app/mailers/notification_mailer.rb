class NotificationMailer < ActionMailer::Base
  def newsletter_signup(email)
    @email = email
    mail(:to => ADMIN_CREDENTIALS["email"], :subject => "New Newsletter Signup!", :from => "Cheaper Computer Care")
  end
end