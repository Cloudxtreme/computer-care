class NewsletterUsersController < ApplicationController
  def create
    user = NewsletterUser.new(params[:newsletter_user])
    if user.save
      NotificationMailer.newsletter_signup(user.email).deliver
      redirect_to root_path, :notice => "Thanks for signing up!"
    else
      redirect_to root_path, :notice => "Something went wrong, please try again making sure you use a valid email address."
    end
  end
end