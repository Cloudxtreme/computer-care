class Admin::NewsletterUsersController < Admin::AdminController
  def index
    @students = StudentCodes.all
  end
end