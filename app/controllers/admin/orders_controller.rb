class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    logger.warn "*"*100
    logger.warn @order.invoice.id.inspect
  end
end