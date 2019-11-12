# Base controller for third-party API requests.
class API::ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :require_api_authentication

private

  def require_api_authentication
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare token, ENV.fetch('MDMA_TOKEN', '')
    end
  end
end
