class PagesController < ApplicationController
    def home
        @newsletter_user = NewsletterUser.new
    end

    def contact
    end

    def contact_send
        if params[:name].empty? || params[:email].empty? || params[:phone].empty? || params[:message].empty?
            redirect_to contact_path, :notice => "Error: All fields are required"
        else
            NotificationMailer.contact_form(params[:name], params[:email], params[:phone], params[:message]).deliver            
            redirect_to contact_path, :notice => "Message sent.  We will be in contact shortly"
        end
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