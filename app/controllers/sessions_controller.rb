# typed: false
# Manages log in and log out through Google authentication.
class SessionsController < ApplicationController
  def new; end

  def auth
    auth = Yt::Auth.create redirect_uri: auth_sessions_url, code: params[:code]
    if auth.email.ends_with? ENV.fetch('EMAIL_DOMAIN', '')
      session[:logged_in] = true
      redirect_to root_url
    else
      redirect_to new_sessions_url, notice: 'Authentication failed.'
    end
  rescue Yt::HTTPError => e
    redirect_to new_sessions_url, notice: "Authentication failed: #{e}"
  end
end
