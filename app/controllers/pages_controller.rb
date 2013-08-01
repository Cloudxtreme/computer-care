class PagesController < ApplicationController
    def home
        @newsletter_user = NewsletterUser.new
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
        @newsletter_user = NewsletterUser.new
        render :partial => "pages/slider"
    end               
end