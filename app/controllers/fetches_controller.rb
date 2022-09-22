# typed: true

# Refresh the list of devices with the app installed.
class FetchesController < ApplicationController
  before_action :require_authentication

  def create
    FetchDevicesJob.perform_later
    redirect_back fallback_location: root_path, notice: 'Devices are being refreshed.'
  end
end
