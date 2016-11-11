class User < ActiveRecord::Base  
	has_many :messages
	has_many :logs
	# has_and_belongs_to_many :messages
	has_secure_password
	before_create :set_auth_token
	# mount_uploader :image, AvatarUploader, 	:mount_on => :avatar

	mount_uploader :avatar, AvatarUploader
	
	def set_auth_token
	self.auth_token = loop do
	  token = SecureRandom.hex
	  break token unless self.class.exists?(auth_token: token)
	end
	end

	def status_check
		x=datetime.today
	if  (user.messages.leave_start_date..user.messages.leave_start_date).include?(x)
		user.status=="not available"
	else
	end
	
	
	end
	

end