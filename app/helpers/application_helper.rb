module ApplicationHelper
    def currency_to_symbol(currency)
        if currency.downcase.eql?("gbp")
            "&pound;"
        else
            "$"
        end
    end

    def is_active(page)
    	"active" if controller.action_name.eql?(page)
    end

    def home_link
    	if controller.action_name.eql?("home")
    		link_to image_tag("home-active.png"), root_path, :id => "home-link", :class => "active"
    	else
    		link_to image_tag("home.png"), root_path, :id => "home-link"
    	end
    end
end
