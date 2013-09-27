class NewsletterUsersController < ApplicationController
  def create
    if !@spam
      if NewsletterUser.where("email" => params[:newsletter_user][:email]).count == 0
        user = NewsletterUser.new(params[:newsletter_user])
        if user.save
          NotificationMailer.newsletter_signup(user.email).deliver
          redirect_to root_path, :notice => "<h4>Thanks for signing up!</h4><p>We'll keep you updated with the latest deals and offers.</p>"
        else
          redirect_to root_path, :alert => "<h4>Something went wrong :(</h4> <p>Please try again making sure you use a valid email address.</p>"
        end
      else
        redirect_to root_path, :notice => "<h4>Thanks for signing up!</h4><p>We'll keep you updated with the latest deals and offers.</p>"
      end
    else
      redirect_to root_path
    end
  end
end