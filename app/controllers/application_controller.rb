class ApplicationController < ActionController::Base
  protect_from_forgery
  http_basic_authenticate_with name: "admin", password: "testingoutthe3c's"
  before_filter :spam_test

  private
      def spam_test
        @spam = false

        if request.get?
          session[:spam_token] = SecureRandom.hex(16) if session[:spam_token].nil?
        elsif request.post?
          if !params[:blanktest].blank? || !params[:tokentest].eql?(session[:spam_token])
              @spam = true
          end
          session[:spam_token] = nil          
        end
      end  
end
