class Admin::NewsletterUsersController < Admin::AdminController
  def index
    @users = NewsletterUser.all
  end
end