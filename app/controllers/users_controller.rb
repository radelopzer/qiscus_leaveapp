class UsersController < ApplicationController
	layout 'dashboard'

	def index
		@users=User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
	    if @user.save
		  redirect_to '/', notice: 'success to create user'
		else
		  render :new, alert: 'fail to create user'
		end
	end
	def destroy
		User.find(params[:id]).destroy
    redirect_to users_url, notice: 'Pengguna berhasil dihapus!'
	end

	def profile_settings

	end

	private

	def user_params
		params.require(:user).permit(:password_confirmation, :username, :auth_token, :email, :password, :role, :amount, :status )
	end
end
