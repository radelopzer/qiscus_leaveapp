class Log < ActiveRecord::Base
	belongs_to :user, class_name: "User",
                    foreign_key: "user_id"

	def create_log(userid, eventmessage)
    	create(userid, eventmessage)
	end

	def self.list_log
    where(user_id: current_user.id)
    end
end
