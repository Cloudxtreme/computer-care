class NotificationMailer < ActionMailer::Base
  def newsletter_signup(email)
    @email = email
    mail(:to => ADMIN_CREDENTIALS["email"], :subject => "New Newsletter Signup!", :from => "info@cheaper_computer_care.com")
  end

  def contact_form(name, email, phone, message)
    @name = name
    @email = email
    @phone = phone
    @message = message
    mail(:to => ADMIN_CREDENTIALS["email"], :subject => "New Contact Form Message", :from => "info@cheaper_computer_care.com")
  end

  def student_discount(name, email, code)
    @name = name
    @code = code
    @email = email
    mail(:to => email, :subject => "Student Discount Code from Cheaper Computer Care", :from => "info@cheaper_computer_care.com")
  end
end