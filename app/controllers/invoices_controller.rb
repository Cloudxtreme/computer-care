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
    @errors = []
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
      @errors << "Something went wrong with your card payment: '#{e.message}'"  
      @errors << "Please try again"
      render :show
      return  
    rescue Stripe::InvalidRequestError => e
      if !e.message.include?("You cannot use a Stripe token more than once")
        @errors << "Something went wrong with your card payment: '#{e.message}'"
        @errors << "Please try again and contact us if the problem persists"
      end
      render :show
      return    
    end

    if !response.paid
      @errors << "Something went wrong with your card payment: '#{response.message}'"
      @errors << "Please try again"
      render :show
      return
    end

    if !@accepted
      @errors << "The terms and conditions must be accepted before  continuing"
      render :show
      return      
    end 

    @order.paid = true
    @order.agreed_to_terms = true
    @order.stripe_charge_id = response.id
    @order.save

    # send confimation to customer
    NotificationMailer.order_confirmation(@order).deliver
    # send notification to admin
    NotificationMailer.order_notification(@order).deliver
    
    redirect_to complete_orders_path
  end
end