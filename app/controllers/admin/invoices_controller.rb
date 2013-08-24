class Admin::InvoicesController < Admin::AdminController
  def create
    order = Order.find(params[:order_id])
    order.invoice = Invoice.new
    redirect_to admin_order_path(order.id)
  end

  def show
    @order = Order.find(params[:order_id])
    @invoice = @order.invoice
    render 'invoices/show'
  end  
end