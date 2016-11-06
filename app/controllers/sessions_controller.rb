class SessionsController < ApplicationController

   

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect_to '/dashboard', notice: 'Login successfully'
    else
      # redirect_to '/login', alert: 'Post successfully created'
    flash[:alert] = 'Sorry, Wrong Username and Password'
redirect_to '/login'

    end
  end
  
  def destroy
    session[:id] = nil
    redirect_to root_url, notice: 'Logout successfully'
  end

end