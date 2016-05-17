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
		  redirect_to '/list_employee', notice: 'success to create user'
		else
		  render :new, alert: 'fail to create user'
		end
	end
	def destroy
		User.find(params[:id]).destroy
    redirect_to users_url, notice: 'Pengguna berhasil dihapus!'
	end

	def update
		@user = current_user
	    if @user.update(user_params)
		  redirect_to '/', notice: 'success to create user'
		else
		  render :new, alert: 'fail to create user'
		end
	end

	def edit
		@user=current_user
	end

	private

	def user_params
		params.require(:user).permit(:avatar, :password_confirmation, :username, :auth_token, :email, :password, :role, :amount, :status, :position )
	end
end
