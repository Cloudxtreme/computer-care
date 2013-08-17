class OrdersController < ApplicationController
  def new
    @services = Service.all
  end

  def create
  end
end