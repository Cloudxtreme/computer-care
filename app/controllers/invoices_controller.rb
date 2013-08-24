class InvoicesController < ApplicationController
  def show
    @order = Order.find(params[:order_id])
    @invoice = @order.invoice
  end

  def payment
    @order = Order.find(params[:order_id])
    @invoice = @order.invoice
    if false #payment successful
      @order.paid = true
      @order.save
      redirect_to complete_orders_path
    else
      render 'show'
    end
  end
end