class NewsletterUsersController < ApplicationController
  def create
    if NewsletterUser.where("email" => params[:newsletter_user][:email]).count == 0
      user = NewsletterUser.new(params[:newsletter_user])
      if user.save
        NotificationMailer.newsletter_signup(user.email).deliver
        redirect_to root_path, :notice => "Thanks for signing up!"
      else
        redirect_to root_path, :notice => "Something went wrong, please try again making sure you use a valid email address."
      end
    else
      redirect_to root_path, :notice => "Thanks for signing up!"
    end
  end
end