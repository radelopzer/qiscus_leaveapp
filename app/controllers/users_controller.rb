class UsersController < ApplicationController
	layout 'dashboard'
	def index
@users = User.all.paginate(:page => params[:page], :per_page => 5)

	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.avatar ||= "/assets/images/default_picture.png"
		@user.avatar
		
	    if @user.save
		   record_activity(current_user.id, 'create user params:[username]' )
		  redirect_to '/list_employee', notice: 'success to create user'
		else
		  render :new, alert: 'fail to create user'
		end
	end
	
	def deactive
		
			@user= User.find(params[:id])
			
				
				if @user.update(user_params)
				
				 record_activity(current_user.id, 'deactive account ')

			else
				redirect_to users_url,alert: 'fail to reject'
			end
		
    redirect_to users_url, notice: 'Success to deactive'
	end


	def update
		@user = current_user
	    if @user.update(user_params)
		  redirect_to '/dashboard', notice: 'Profile Changed'
		else
		  render :new, alert: 'Fail to Change'
		end
	end

	def edit
		@user=current_user
	end

	private

	def user_params
		params.require(:user).permit( :contract, :gender,:avatar, :password_confirmation, :username, :auth_token, :email, :password, :role, :amount, :status, :position )
	end
end
