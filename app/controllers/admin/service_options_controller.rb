class Admin::ServiceOptionsController < Admin::AdminController
  def new
    @service = Service.find(params[:service_id])
    @service_option = @service.service_options.new
  end

  def create
    @service = Service.find(params[:service_id])
    @service_option = @service.service_options.new(params[:service_option]) 
    if @service_option.save
      redirect_to admin_service_path(@service.id)
    else
      render 'new'
    end
  end
end