class SessionsController < ApplicationController
  def new
  end

  def create
    user = Admin.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_dashboard_path
    else
      render "new"
    end    
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end