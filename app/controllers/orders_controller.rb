class OrdersController < ApplicationController
  def new
    if !params[:back]
      session["first-name"] = nil
      session["last-name"] = nil
      session["email"] = nil
      session["telephone"] = nil
      session["building"] = nil
      session["street"] = nil
      session["town"] = nil
      session["postcode"] = nil
      session["options"] = nil
      session["discount"] = nil
      session["date"] = nil
    end
    @order = Order.new
    @services = Service.where(:can_checkout => true) 
    @options = {}
    @missing = []
    @invalid = []
  end

  def create
    session["first-name"] = params["first-name"]
    session["last-name"] = params["last-name"]
    session["email"] = params["email"]
    session["telephone"] = params["telephone"]
    session["building"] = params["building"]
    session["street"] = params["street"]
    session["town"] = params["town"]
    session["postcode"] = params["postcode"]
    session["options"] = params[:options] ? params[:options].select { |service_id, options| params[:services].include?(service_id) } : {}
    session["date"] = params["date"] if params["date"]
    session["date"] = "#{params["date-fallback"]["month"]}/#{params["date-fallback"]["day"].to_i+1}/#{params["date-fallback"]["year"]}" if params["date-fallback"]

    if !params["complete_date"]
      date = params["date"].split("/") if params["date"]
      date = [params["date-fallback"]["month"], params["date-fallback"]["day"].to_i + 1, params["date-fallback"]["year"]] if params["date-fallback"]
      delivery_date = Time.new(date.last, date.first, date.second) if !date.blank?
      delivery_date = delivery_date + 1.hour
    else
      delivery_date = params["complete_date"]
    end

    @order = Order.new({:date => delivery_date, :building => params[:building], :email => params[:email], :first_name => params["first-name"], :last_name => params["last-name"], :postcode => params["postcode"], :street => params["street"], :telephone => params["telephone"], :town => params["town"]})    
    @service_options = {}
    @options = params[:options] ? params[:options].select { |service_id, options| params[:services].include?(service_id) } : {}
    @services = Service.all
    
    @discount = nil
    if !params[:discount].blank?
      @discount = StudentCode.where("code = '#{params[:discount]}'").first 
      session["discount"] = params[:discount] if @discount && @discount.is_valid
    end
    if session["discount"]
      #session["discount"] = nil
      @discount = StudentCode.where("code = '#{session[:discount]}'").first 
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
    else
      @accepted = true
      render :confirm
    end
  end

  def finalize
    @options = params[:options]
    @order = Order.new(params[:order])
    @discount = nil
    if !params[:discount].blank?
      @discount = StudentCode.where("code = '#{params[:discount]}'").first 
      session["discount"] = params[:discount] if @discount && @discount.is_valid
    end
    @services = Service.all
    @missing = []
    @invalid = []   
    @accepted = true 
    if !params[:accept_terms].blank? 
      @order.agreed_to_terms = true
      
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
    else
      @accepted = false
      render :confirm
    end
  end

  def complete
  end
end