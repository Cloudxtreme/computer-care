class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.all.sort { |a,b| Time.at(b.created_at) <=> Time.at(a.created_at) }
  end

  def show
    @order = Order.find(params[:id])
  end
end