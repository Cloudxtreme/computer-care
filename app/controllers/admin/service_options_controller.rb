class Admin::ServiceOptionsController < Admin::AdminController
  def new
    @service = Service.find(params[:service_id])
    @service_option = @service.service_options.new

    if request.xhr?
      render :partial => 'form'
    else
      render 'new'
    end
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

  def destroy
    service = Service.find(params[:service_id])
    service_option = ServiceOption.find(params[:id])
    service_option.destroy
    redirect_to admin_service_path(service.id)
  end
end