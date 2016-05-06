class User < ActiveRecord::Base
	has_many :message
	has_secure_password
	before_create :set_auth_token

	def set_auth_token
	self.auth_token = loop do
	  token = SecureRandom.hex
	  break token unless self.class.exists?(auth_token: token)
	end
	end

end