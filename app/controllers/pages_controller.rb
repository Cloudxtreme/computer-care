class PagesController < ApplicationController    
    def home
        @newsletter_user = NewsletterUser.new
    end

    def contact
    end

    def contact_send
        if !@spam
            if params[:name].empty? || params[:email].empty? || params[:phone].empty? || params[:message].empty?
                redirect_to contact_path, :alert => "<h4>All fields are required</h4><p>Please fill out all the fields so we can help you out as best we can.</p>"
            else
                NotificationMailer.contact_form(params[:name], params[:email], params[:phone], params[:message]).deliver            
                redirect_to root_path, :notice => "<h4>Message sent</h4><p>Thanks! We will be in contact shortly</p>"
            end
        else
            redirect_to root_path
        end
    end

    def about
    end

    def offers
        @newsletter_user = NewsletterUser.new        
    end

    def faq
    end

    def terms
    end    

    def slider
        @newsletter_user = NewsletterUser.new
        render :partial => "pages/slider"
    end     

    def privacy
    end
end