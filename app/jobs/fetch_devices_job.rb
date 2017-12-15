class FetchDevicesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Device.destroy_all

    devices = SimpleMDM::Device.all
    devices.each do |device|
      app = device.installed_apps.find{|app| app["identifier"] == "com.clutter.UglySweater"}
      Device.create! name: device.name, app_version: app.version if app
    end
  end
end
