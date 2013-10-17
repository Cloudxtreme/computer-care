class InvoicesController < ApplicationController
  def show
    @order = Order.find(params[:order_id])
    @invoice = @order.invoice
    date = Date.today
    timezone = ActiveSupport::TimeZone['London']    
    time = timezone.local(date.year, date.month, date.day) + 13.hours
    @can_collect_today = Time.now < time    
  end

  def payment
    @order = Order.find(params[:order_id])
    @invoice = @order.invoice
    @accepted = params[:accept_terms] && params[:accept_terms].eql?("on") ? true : false

    date = Date.today
    timezone = ActiveSupport::TimeZone['London']    
    time = timezone.local(date.year, date.month, date.day) + 13.hours
    @can_collect_today = Time.now < time

    date = params["date"].split("/") if params["date"]
    delivery_date = Time.new(date.last, date.first, date.second) if !date.blank?
    delivery_date = delivery_date + 1.hour

    @order.date = delivery_date
    if @accepted #payment successful
      @order.paid = true
      @order.agreed_to_terms = true
      #@order.save
      redirect_to complete_orders_path
    else
      render 'show'
    end
  end
end