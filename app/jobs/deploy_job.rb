require 'slack'

class DeployJob < ActiveJob::Base
  queue_as :default

  def perform(build)
    app = SimpleMDM::App.find 16714
    file = Tempfile.open ['package', '.ipa'], encoding: 'ASCII-8BIT'
    file.write build.package.download
    app.binary = file.open
    app.save

    app_group = SimpleMDM::AppGroup.find 21708 # 7017
    app_group.push_apps

    app_devices = SimpleMDM::Device.all.select do |device|
      device.device_group_id.in? app_group.device_group_ids
    end

    app_devices.map &:refresh

    Slack.notify "Build of #{app.name} released to #{app_devices.size} devices."

    build.successful!
  end
end
