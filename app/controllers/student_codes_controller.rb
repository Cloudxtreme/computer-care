class StudentCodesController < ApplicationController
  def new
    @discount_code = StudentCode.new
  end

  def create
    @discount_code = StudentCode.new(params[:student_code])
    if @discount_code.save
      redirect_to root_path, :notice => "<h4>Nice one!</h4><p>Your discount code has been sent to your email address</p>"
    else
      redirect_to new_student_code_path, :alert => "<h4>Something went wrong :(</h4><p>Make sure you have provided a valid UK student email address (ending in .ac.uk) and your full name</p>"
    end
  end
end