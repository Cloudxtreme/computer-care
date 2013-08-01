class NotificationMailer < ActionMailer::Base
  def newsletter_signup(email)
    @email = email
    mail(:to => ADMIN_CREDENTIALS["email"], :subject => "New Newsletter Signup!", :from => "Cheaper Computer Care")
  end

  def contact_form(name, email, phone, message)
    @name = name
    @email = email
    @phone = phone
    @message = message
    mail(:to => ADMIN_CREDENTIALS["email"], :subject => "New Contact Form Message", :from => "Cheaper Computer Care")
  end
end