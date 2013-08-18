class OrdersController < ApplicationController
  def new
    @services = Service.all
    @missing = []
  end

  def create
    @services = Service.all
    required = ["first-name", "last-name", "email", "telephone", "buidling", "street", "town", "postcode"]
    @missing = []
    required.each do |param|      
      @missing << param if params[param].blank?
    end

    if @missing.any?
      render :new
      #redirect_to new_order_path, :notice => ""
    else
    end
  end
end