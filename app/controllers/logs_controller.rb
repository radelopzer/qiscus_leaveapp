class LogsController < ApplicationController
	layout 'dashboard'

	def index
		
		# @logs = Log.select(" logs.user_id,logs.id, logs.event, logs.event_time,users.id as u_id,
  #   				users.username").joins(:user).where('users.user_id =?', current_user.id)
  		@logs = Log.joins(:user).where('users.id =?', current_user.id)
		
	end

	# def create(userid, message)
	# 	@log = Log.new
	# 	@log.user_id = current_user.id
	# 	@log.event = 'testmessage'
	# 	@log.save
	# end

	private

	def log_params
		params.require(:log).permit(:user_id, :id, :event, :event_time)
	end
end
