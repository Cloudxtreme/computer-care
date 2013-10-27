class NotificationMailer < ActionMailer::Base  
  def newsletter_signup(email)
    @email = email    
    mail(:to => admin_emails, :subject => "New Newsletter Signup!", :from => "info@cheaper_computer_care.com") if admin_emails
  end

  def contact_form(name, email, phone, message)
    @name = name
    @email = email
    @phone = phone
    @message = message
    mail(:to => admin_emails, :subject => "New Contact Form Message", :from => "info@cheaper_computer_care.com") if admin_emails
  end

  def student_discount(name, email, code)
    @name = name
    @code = code
    @email = email
    mail(:to => email, :subject => "Student Discount Code from Cheaper Computer Care", :from => "info@cheaper_computer_care.com")
  end

  def order_confirmation(order)
    @order = order
    mail(:to => @order.email, :subject => "Cheaper Computer Care Order Confirmation", :from => "info@cheaper_computer_care.com")
  end

  def order_notification(order)
    @order = order
    mail(:to => admin_emails, :subject => "Cheaper Computer Care Order Received", :from => "info@cheaper_computer_care.com") if admin_emails
  end

  def quote_confirmation(order)
    @order = order
    mail(:to => @order.email, :subject => "Cheaper Computer Care Quote", :from => "info@cheaper_computer_care.com")
  end

  def quote_notification(order)
    @order = order
    mail(:to => admin_emails, :subject => "Cheaper Computer Care Quote Request Received", :from => "info@cheaper_computer_care.com") if admin_emails
  end

  private
    def admin_emails
      if Admin.count > 0
        emails = Admin.all.collect { |user| user.email }.join(", ")
      else
        nil
      end
    end
end