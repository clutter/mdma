# typed: false
# Methods to log in via Google apps
module GoogleHelper
  def google_auth_url
    Yt::Auth.url_for redirect_uri: auth_sessions_url
  end
end
