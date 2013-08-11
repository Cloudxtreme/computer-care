class Admin::ServicesController < Admin::AdminController
  def index
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(params[:service])
    if @service.save
      redirect_to admin_services_path
    else
      render 'new'
    end
  end

  def destroy
    service = Service.find(params[:id])
    service.destroy
    redirect_to admin_services_path
  end
end