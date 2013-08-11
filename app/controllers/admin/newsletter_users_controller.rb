class Admin::NewsletterUsersController < Admin::AdminController
  def index
    @users = NewsletterUser.all
  end

  def destroy
    user = NewsletterUser.find(params[:id])
    user.destroy
    redirect_to admin_newsletter_users_path
  end
end