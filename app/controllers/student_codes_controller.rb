class StudentCodesController < ApplicationController
  def new
    @discount_code = StudentCode.new
  end

  def create
    @discount_code = StudentCode.new(params[:student_code])
    if @discount_code.save
      flash[:notice] = "Your discount code has been sent to your email address"
      redirect_to root_path
    else
      render 'new'
    end
  end
end