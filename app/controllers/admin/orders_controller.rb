class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.all.sort { |a,b| b.created_at <=> a.created_at }
  end

  def show
    @order = Order.find(params[:id])
  end

  def update_cost
    @order = Order.find(params[:id])
    @order.total_cost = params[:cost]
    @order.save
    redirect_to admin_order_path(@order.id), :notice => "total cost updated"
  end
end