class MessagesController < ApplicationController

	layout 'dashboard'
		def index
		
			@messages = Message.select("messages.id, messages.message, messages.approval_status, messages.leave_start_date, messages.leave_end_date, messages.amount_taken, messages.admin_respond, messages.category, users.id as u_id,
    				users.username").joins(:user).paginate(:page => params[:page],:per_page => 5)
		end

		def new
		@message =Message.new
		
		end
		def edit

		end

		def create
		@message = Message.new(message_params)
		
		@message.user_id=current_user.id
	    working_days = @message.calculate_working_day
	    @message.amount_taken = working_days
	    	@message.send_date = Date.today.to_s
	    	if 	

	    		@message.amount_taken<= current_user.amount && @message.amount_taken>0
				@message.save
				 record_activity(current_user.id, 'create message')
		
				# redirect_to '/list_messages', notice: 'success to create message'
		redirect_to url_for(:controller => :logs, :action => :index) and return
			else
				render :new, alert: 'fail to create message'
			end
		end

		
  		def approve
	    #	if current_user
	    # if current_user.admin?
	    		
	    @message = Message.find(params[:id])
	    @user = User.find(@message.user_id)
	    		if	@message.approval_status=="new" || @message.approval_status=="renew"
	    			
	    			@user.update(amount: @user.amount-@message.amount_taken)  
				    @message.update(message_params)
				    record_activity(current_user.id, 'approve message')
				    redirect_to messages_url,notice: 'approved'

			else
				redirect_to messages_url,alert: "insuffician amount"
			    
	    	#else
	      		#redirect_to messages_url,alert: 'fail to approve'
	  		end
		end

		def reject
			@message= Message.find(params[:id])
			if 
				@message.approval_status=="new" || @message.approval_status=="renew"
				
				@message.update(message_params)
				redirect_to messages_url,notice: 'rejected'
				 record_activity(current_user.id, 'reject message')

			else
				redirect_to messages_url,alert: 'fail to reject'
			end
		end
		def update
		@message = Message.find(params[:id])
		@message.update(message_params)
      	redirect_to messages_url,notice: "success"
  		end

		def resubmit_mess
			if 
				current_user
				@message.update(message_params)
				 record_activity(current_user.id, 'resubmit message')
				 redirect_to static_pages_url,notice: 'success to resubmit message'	
			else
				redirect_to messages_url,alert: 'fail to resubmit'
			end
		end

		def resubmit
			@message=Message.find_by_approval_status_and_user_id("recheck",current_user.id)
			 
		end
		
		def reply
		@message=Message.find(params[:id])
		if @message.approval_status=="new" || @message.approval_status=="renew"
			# @message.reply
			@message.update(message_params)	
			redirect_to messages_url,notice: 'reply message sent'
			 record_activity(current_user.id, 'reply message')
		else
			redirect_to messages_url,notice: 'fail to send'
		end
		end

		def list_messages_approved
		@messages=Message.all
		end
		
		private

		def message_params
			params.require(:message).permit(:user_id, :amount_taken, :category, :approval_status, :message, :leave_start_date, :leave_end_date, :send_date, :checked_date, :admin_respond)
		end
end