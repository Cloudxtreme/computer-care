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
    @options = params[:options]
    @services = Service.all
    
    required = ["first-name", "last-name", "email", "telephone", "building", "street", "town", "postcode"]
    @missing = []
    @invalid = []

    required.each do |param|      
      @missing << param if params[param].blank?
    end

    if @missing.any?
      render :new
    elsif (/^([a-zA-Z0-9\-\._]+)@((?:[-a-z0-9]+\.)+[a-z]{2,4})$/i =~ params[:email]).nil?
      @invalid << "email"
      render :new
    else
      render :confirm
    end
  end

  def finalize
    @order = Order.new(params[:order])

    if params[:paid]
      @order.paid = true
    else
      @order.paid = false
    end
    
    @services = Service.all
    @missing = []
    @invalid = []

    total = 0.0
    params[:options].each do |service_id, options|
      service = Service.find(service_id)
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

    if @order.save
      params[:options].each do |service_id, options|
        order_service = @order.order_services.create(:service_id => service_id)
        options.each do |option_id, value|
          service_option = order_service.order_service_options.create(:service_option_id => option_id, :value => value)
        end
      end

      redirect_to complete_orders_path
    else
      render :new
    end
  end

  def complete
  end
end