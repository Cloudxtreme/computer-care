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

    def snippet(text, wordcount=10) 
        text.split[0..(wordcount-1)].join(" ") + (text.split.size > wordcount ? "..." : "") 
    end

    def expiry_month_options
        "<option value='1'>01</option>" +
        "<option value='2'>02</option>" +
        "<option value='3'>03</option>" +
        "<option value='4'>04</option>" +
        "<option value='5'>05</option>" +
        "<option value='6'>06</option>" +
        "<option value='7'>07</option>" +
        "<option value='8'>08</option>" +
        "<option value='9'>09</option>" +
        "<option value='10'>10</option>" +
        "<option value='11'>11</option>" +
        "<option value='12'>12</option>".html_safe
    end

    def expiry_year_options
        options = ""
        16.times do |i|
            options += "<option value='#{Date.today.strftime('%y').to_i + i + 2000}'>#{Date.today.strftime('%y').to_i + i}</option>"
        end
        options.html_safe
    end
end
