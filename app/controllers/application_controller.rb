# typed: true
# Base controller without any special behavior
class ApplicationController < ActionController::Base
  def logged_in?
    session[:logged_in]
  end

  def require_authentication
    redirect_to new_sessions_path unless logged_in?
  end

  helper_method :logged_in?
end
