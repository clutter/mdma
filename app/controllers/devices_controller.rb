# Displays the devices with the app installed.
class DevicesController < ApplicationController
  before_action :require_authentication

  def index
    @devices = Device.select(:app_version, :name).order('app_version desc nulls last').group_by(&:app_version)
  end

  def update
    SimpleMDM::Device.find(121002).push_apps
    redirect_back fallback_location: root_path, notice: 'App is being pushed to device.'
  rescue *connection_errors
    redirect_back fallback_location: root_path, alert: 'Could not push app to device.'
  end

private

  # Returns a list of connection errors worth retrying at least once.
  def connection_errors
    [
      OpenSSL::SSL::SSLError, Errno::ETIMEDOUT, Errno::EHOSTUNREACH, Errno::ENETUNREACH, Errno::ECONNRESET,
      SocketError, Net::OpenTimeout, Net::HTTPServerError, OpenSSL::SSL::SSLErrorWaitReadable, RestClient::Exception
    ]
  end
end
