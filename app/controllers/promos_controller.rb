class PromosController < ApplicationController
	layout 'dashboard'
	
	def index
    @promo = Promo.all
    @new = Promo.new
    @list_taken = Promo.joins(:management)
    @expire_list = Promo.where("expired_date < ?", Date.today)
    #where.not( taker_id: nil)
  	end

  	def new
	@promo =Promo.new
		
	end

	def take_promo

	@promo = Promo.find(params[:id])
	if  
				    @promo.update(promo_params)
				    record_activity(current_user.id, 'approve message')
				   
				    redirect_to '/dashboard',notice: 'approved'

			else
				redirect_to messages_url,alert: "insuffician amount"
			    
	    	#else
	      		#redirect_to messages_url,alert: 'fail to approve'
	  		end 

	end

	def update
		@promo = Promo.find(params[:id])
		@promo.update(promo_params)
      	redirect_to '/static_pages',notice: "success"
  		end

	def create
		@promo = Promo.new(promo_params)
	    	if 	
	    		@promo.user_id=current_user.id
	    		current_user.role=="manager"
				@promo.save
				 record_activity(current_user.id, 'create promo')
		
				
		  redirect_to '/promos', notice: 'success to create promo'
			else
				render :new, alert: 'fail to create message'
			end
	end

	

	private

		def promo_params
			params.require(:promo).permit(:expired_date, :taker_id, :user_id, :start_date, :end_date, :title, :message)
		end
end

