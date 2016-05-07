class MessagesController < ApplicationController


	layout 'dashboard'
		def index
			@message = Message.joins(:user) 
			@messages = Message.all
			@messages = Message.select("*").joins(:user)
			@messages = Message.select("messages.id, messages.approval_status, messages.leave_start_date, messages.leave_end_date, messages.amount_taken, users.id as u_id,
    				users.username").joins(:user)
		end

		def new
		@message =Message.new
		end

		def create
		@message = Message.new(message_params)
		@message.user_id=current_user.id
	    working_days = @message.calculate_working_day
	    @message.amount_taken = working_days
	    	@message.send_date = Date.today.to_s
	    if 	@message.amount_taken<= current_user.amount
	    	@message.save
		
			redirect_to '/list_messages', notice: 'success to create message'
		else
			render :new, alert: 'fail to create message'
		end 
		end

		 def update
		@message = Message.find(params[:id])
    	if @message.update(message_params)
      	redirect_to messages_url, notice: 'Approved'
	  	else
      	redirect_to messages_url, alert: 'fail to approve'
	  	end
  		end
	
		private

		def message_params
			params.require(:message).permit(:user_id, :amount_taken, :approval_status, :message, :leave_start_date, :leave_end_date, :send_date, :checked_date)
		end
end