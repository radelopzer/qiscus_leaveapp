class SessionsController < ApplicationController

  # def new
    
  # end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect_to '/dashboard', notice: 'Selamat datang!'
    else
      redirect_to '/login', alert: 'Mohon cek kembali email atau password Anda!'
    end
  end
  
  def destroy
    session[:id] = nil
    redirect_to root_url, notice: 'Berhasil keluar! Sampai ketemu lagi :)'
  end

end