# Ask SimpleMDM to refresh the list of apps on each device.
class FetchDevicesJob < ActiveJob::Base
  queue_as :default

  def perform
    remove_missing_devices
    update_current_devices
  end

private

  def remove_missing_devices
    Device.where.not(name: app_devices.map(&:name)).destroy_all
  end

  def update_current_devices
    app_devices.each do |device|
      app = device.installed_apps.find do |app|
        app['identifier'] == 'com.clutter.scan-wms'
      end

      device = Device.find_or_initialize_by name: device.name
      device.app_version = app.version if app
      device.save!
    end
  end

  def app_devices
    @app_devices ||= begin
      app_group = SimpleMDM::AppGroup.find 7017
      SimpleMDM::Device.all.select do |device|
        device.device_group_id.in? app_group.device_group_ids
      end
    end
  end
end
