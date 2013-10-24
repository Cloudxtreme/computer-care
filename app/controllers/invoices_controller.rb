class InvoicesController < ApplicationController
  def show
    @errors = []
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

    stripe_token = params["stripe-token"]
    begin
      response = Stripe::Charge.create(
        :amount => @order.total_cost * 100,
        :currency => "gbp",
        :card => stripe_token,
        :description => "Cheaper Computer Care"
      )
    rescue Stripe::CardError => e
      redirect_to order_invoice_path(@order.id), :alert => e.message
      return
    rescue Stripe::InvalidRequestError => e
      redirect_to order_invoice_path(@order.id), :alert => e.message
      return
    rescue Exception => e
      redirect_to order_invoice_path(@order.id), :alert => e.message
      return      
    end

    if @accepted && response.paid
      @order.paid = true
      @order.agreed_to_terms = true
      @order.stripe_charge_id = response.id
      @order.save

      # send confimation to customer
      NotificationMailer.order_confirmation(@order).deliver
      # send notification to admin
      NotificationMailer.order_notification(@order).deliver
      
      redirect_to complete_orders_path
    else
      render 'show'
    end
  end
end