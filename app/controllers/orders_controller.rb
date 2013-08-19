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
    @services = Service.all
    @missing = []
    @invalid = []

    if @order.save
      redirect_to complete_orders_path
    else
      render :new
    end
  end

  def complete
  end
end