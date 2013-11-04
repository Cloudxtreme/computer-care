class ServicesController < ApplicationController
    def quote
        @service = Service.find(params[:id])
        redirect_to root_path if @service.can_checkout
        @missing = []
        @invalid = []
        @services = []
    end

    def quote_send
        @missing = []
        @invalid = []        
        @service = Service.find(params[:id])
        @order = Order.new(params[:order])
        @order.paid = false

        if !params[:options]
            redirect_to quote_service_path(@service.id), :alert => "Error: no service options received"
            return
        end

        if params[:options].any? and @order.save
            params[:options].each do |service_id, options|
                order_service = @order.order_services.create(:service_id => service_id)
                options.each do |option_id, value|
                    service_option = order_service.order_service_options.create(:service_option_id => option_id, :value => value)
                end
            end

            # send confimation to customer
            NotificationMailer.quote_confirmation(@order).deliver
            # send notification to admin
            NotificationMailer.quote_notification(@order).deliver

            render 'quote_complete'
        else
            render :quote
        end
    end

    def index
    end

    def data_recovery
        #if request.headers['X-PJAX']
        if request.xhr?
            render :partial => "data_recovery"
        else
            render "data_recovery"
        end
    end   

    def replacement_parts
        #if request.headers['X-PJAX']
        if request.xhr?
            render :partial => "replacement_parts"
        else
            render "replacement_parts"
        end
    end

    def virus_removal
        #if request.headers['X-PJAX']
        if request.xhr?
            render :partial => "virus_removal"
        else
            render "virus_removal"
        end
    end        

    def servicing
        #if request.headers['X-PJAX']
        if request.xhr?
            render :partial => "servicing"
        else
            render "servicing"
        end
    end   

    def upgrades
        #if request.headers['X-PJAX']
        if request.xhr?
            render :partial => "upgrades"
        else
            render "upgrades"
        end
    end 

    def repairs
        #if request.headers['X-PJAX']
        if request.xhr?
            render :partial => "repairs"
        else
            render "repairs"
        end
    end     
end