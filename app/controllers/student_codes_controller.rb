class StudentCodesController < ApplicationController
  def new
    @discount_code = StudentCode.new
  end

  def create
    @discount_code = StudentCode.new(params[:student_code])
    if @discount_code.save
      redirect_to root_path
    else
      logger.warn @discount_code.errors.inspect
      logger.warn "*"*100
      render 'new'
    end
  end
end