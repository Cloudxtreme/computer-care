class Admin::DiscountCodesController < Admin::AdminController
  def create
    DiscountCode.create(:discount => params[:discount])
    redirect_to admin_discount_codes_path
  end

  def index
    @codes = DiscountCode.all
  end

  def destroy
    code = DiscountCode.find(params[:id])
    code.destroy
    redirect_to admin_discount_codes_path
  end
end