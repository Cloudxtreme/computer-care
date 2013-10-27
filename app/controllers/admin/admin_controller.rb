require "digest/sha1"

class Admin::AdminController < ApplicationController
	before_filter :authenticate

	def dashboard
	end

	private
		def authenticate
			if session[:user_id]
				user = Admin.find(session[:user_id])
				if user

				else
					redirect_to root_path
					return
				end
			else
				redirect_to root_path
				return
			end
		end
end