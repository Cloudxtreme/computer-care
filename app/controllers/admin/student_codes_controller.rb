class Admin::StudentCodesController < Admin::AdminController
  def index
    @students = StudentCode.all
  end

  def destroy
    @discount = StudentCode.find(params[:id])
    #@discount.code = nil
    @discount.is_valid = false
    @discount.save
    redirect_to admin_student_codes_path
  end
end