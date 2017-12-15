class ApplicationController < ActionController::Base
  def logged_in?
    session[:logged_in]
  end

  def require_authentication
    redirect_to new_sessions_path unless logged_in?
  end
end
