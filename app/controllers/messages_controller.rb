class MessagesController < ApplicationController


	layout 'dashboard'
		def index
			@messages=Message.all
		end

		def new
		@message =Message.new
		end

		def create
		@message = Message.new(message_params)
	    @message.sender_id = current_user.id
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
    if current_user.role=1?

    @message = Message.find(params[:id])
     @user = User.find(@message.sender_id)
    @user.update(amount: @user.amount-@message.amount_taken)  
    render notice: {
      success: true,
      message: "leave approved",
    }
    else
      render notice: {
        success: false,
        message:"access denied"
      }
  end
    # 1. Get the messagge to be approved
    # 2. update the status to APPROVED
    # 3. update the user amount
    # 4. render json: success/failed
  end
		private

		def message_params
			params.require(:message).permit(:sender_id, :amount_taken, :approval_status, :message, :leave_start_date, :leave_end_date, :send_date, :checked_date)
		end
end