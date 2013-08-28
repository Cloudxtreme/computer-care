class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.all.sort { |a,b| b.created_at <=> a.created_at }
  end

  def show
    @order = Order.find(params[:id])
  end
end