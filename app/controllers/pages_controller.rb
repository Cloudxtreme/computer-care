class PagesController < ApplicationController
    def home
    end

    def contact
    end

    def about
    end

    def offers
    end

    def faq
    end

    def terms
    end    

    def slider
        render :partial => "pages/slider"
    end               
end