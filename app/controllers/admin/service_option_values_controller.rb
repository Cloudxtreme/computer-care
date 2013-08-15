class Admin::ServiceOptionValuesController < Admin::AdminController
  def new
    @service = Service.find(params[:service_id])
    @option = ServiceOption.find(params[:service_option_id])
    @value = ServiceOptionValue.new

    if request.xhr?
      render :partial => "form"
    else
      render "new"
    end
  end

  def create
    @service = Service.find(params[:service_id])
    @option = ServiceOption.find(params[:service_option_id])
    @value = @option.service_option_values.new(params[:service_option_value]) 
    if @value.save
      redirect_to admin_service_path(@service.id)
    else
      render 'new'
    end
  end

  def destroy
    service = Service.find(params[:service_id])
    option_value = ServiceOptionValue.find(params[:id])
    option_value.destroy

    redirect_to admin_service_path(service.id)
  end
end