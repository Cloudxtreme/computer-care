require "digest/sha1"

class Admin::AdminController < ApplicationController
	before_filter :authenticate

	def dashboard
	end

	private
		def authenticate
			authenticate_or_request_with_http_basic do |user, password|
				sha256 = Digest::SHA256.new
				user_hash = Digest::SHA1.hexdigest(user)
				pass_hash = Digest::SHA1.hexdigest(password)

				user_hash.eql?(ADMIN_CREDENTIALS["user"]) && pass_hash.eql?(ADMIN_CREDENTIALS["pass"])
			end
		end
end