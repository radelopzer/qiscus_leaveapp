class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :set_time_zone, :current_user, :create_log, :record_activity, :current_user_log
  def current_user
    @current_user ||= User.find_by(id: session[:id])

  end

  def current_user_log
    @log = Log.find_by(user_id: session[:id])
  end

  def manager
  	@current_user.role = 2
  end
  
  def record_activity(userid, message)
    @activity = Log.new
    @activity.user_id = userid
    @activity.event = message
    @activity.save
  end

  def set_time_zone
        Time.zone = current_user.time_zone
  end

end
