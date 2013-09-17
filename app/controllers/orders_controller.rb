class OrdersController < ApplicationController
  def new
    @order = Order.new
    @services = Service.all    
    @missing = []
    @invalid = []
  end

  def create
    date = params["date"].split("/")
    delivery_date = Time.new(date.last, date.first, date.second, params["time"]["hour"], params["time"]["minute"], 0)

    @order = Order.new({:date => delivery_date, :building => params[:building], :email => params[:email], :first_name => params["first-name"], :last_name => params["last-name"], :postcode => params["postcode"], :street => params["street"], :telephone => params["telephone"], :town => params["town"]})
    @service_options = {}
    @options = params[:options] ? params[:options] : []
    @services = Service.all
    
    @discount = nil
    if !params[:discount].blank?
      @discount = StudentCode.where("code = '#{params[:discount]}'").first 
    end
    
    required = ["first-name", "last-name", "email", "telephone", "building", "street", "town", "postcode"]
    @missing = []
    @invalid = []

    required.each do |param|      
      @missing << param if params[param].blank?
    end
    @missing << "services" if @options.empty?

    if @missing.any?
      render :new
    elsif (/^([a-zA-Z0-9\-\._]+)@((?:[-a-z0-9]+\.)+[a-z]{2,4})$/i =~ params[:email]).nil?
      @invalid << "email"
      render :new
    elsif (!params[:discount].blank? && @discount.nil?) || (!@discount.nil? && !@discount.is_valid)
      @invalid << "discount code"
      render :new
    else
      render :confirm
    end
  end

  def finalize
    @order = Order.new(params[:order])
    
    @services = Service.all
    @missing = []
    @invalid = []

    total = 0.0
    services_that_need_quote = []
    params[:options].each do |service_id, options|
      service = Service.find(service_id)
      services_that_need_quote << service if !service.can_checkout
      total += service.base_cost

      options.each do |service_option, value|
        option = ServiceOption.find(service_option)

        if !option.is_arbitrary
          option_value = ServiceOptionValue.find(value)
          total += option_value.additional_cost
        end
      end
    end

    @order.total_cost = total

    if params[:discount]
      @discount = StudentCode.where("code = '#{params[:discount]}'").first 
      if @discount
        @order.total_cost = @order.total_cost - (@order.total_cost * 0.15)
        @order.student_code_id = @discount.id
        @discount.is_valid = false
        @discount.save
      end
    end

    if services_that_need_quote.any?
      @order.paid = false
    elsif false # payment completed successfully
      @order.paid = true
    else # payment completed unsuccesfully 
      @order.paid = false
    end

    if params[:options].any? and @order.save
      params[:options].each do |service_id, options|
        order_service = @order.order_services.create(:service_id => service_id)
        options.each do |option_id, value|
          service_option = order_service.order_service_options.create(:service_option_id => option_id, :value => value)
        end
      end

      # send confimation to customer
      NotificationMailer.order_confirmation(@order).deliver
      # send notification to admin
      NotificationMailer.order_notification(@order).deliver

      redirect_to complete_orders_path
    else
      render :new
    end
  end

  def complete
  end
end