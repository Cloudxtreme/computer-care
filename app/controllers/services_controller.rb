class ServicesController < ApplicationController
  def index
  end

    def data_recovery
        if request.headers['X-PJAX']
            render :partial => "data_recovery"
        else
            render "data_recovery"
        end
    end   

    def replacement_parts
        if request.headers['X-PJAX']
            render :partial => "replacement_parts"
        else
            render "replacement_parts"
        end
    end

    def virus_removal
        if request.headers['X-PJAX']
            render :partial => "virus_removal"
        else
            render "virus_removal"
        end
    end        

    def servicing
        if request.headers['X-PJAX']
            render :partial => "servicing"
        else
            render "servicing"
        end
    end   

    def upgrades
        if request.headers['X-PJAX']
            render :partial => "upgrades"
        else
            render "upgrades"
        end
    end 

    def repairs
        if request.headers['X-PJAX']
            render :partial => "repairs"
        else
            render "repairs"
        end
    end     
end