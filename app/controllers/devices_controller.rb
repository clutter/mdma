# typed: true

# Displays the devices with the app installed.
class DevicesController < ApplicationController
  before_action :require_authentication

  def index
    @devices = Device.select(:app_version, :name).order('app_version desc nulls last').group_by(&:app_version)
  end
end
