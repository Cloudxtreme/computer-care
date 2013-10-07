module ApplicationHelper
    def currency_to_symbol(currency)
        if currency.downcase.eql?("gbp")
            "&pound;"
        else
            "$"
        end
    end

    def is_active(controller_name, action_name=nil)
        if action_name
    	   "active" if controller.controller_name.eql?(controller_name) && controller.action_name.eql?(action_name)
        else
            "active" if controller.controller_name.eql?(controller_name)
        end
    end

    def home_link
    	if controller.action_name.eql?("home")
    	   link_to image_tag("home-icon.png"), root_path, :id => "home-link", :class => "active"
    	else
    	   link_to image_tag("home.png"), root_path, :id => "home-link"
    	end
    end

    def is_checked(options, service_id)
        if options
            if options.any? && options.has_key?(service_id)
                true
            elsif !options.any? && params[:service] && params[:service].eql?(service_id)
                true
            end
        end
    end

    def form_value(session_value)
        if session_value
            "value='#{session_value}'".html_safe
        else
            ""
        end
    end
end
