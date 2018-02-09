require 'slack'

class DeployJob < ActiveJob::Base
  queue_as :default

  def perform(deploy)
    app = SimpleMDM::App.find(16_714)
    Slack.notify "Build of #{app.name} started."
    deploy.running!

    file = Tempfile.open ['package', '.ipa'], encoding: 'ASCII-8BIT'
    file.write deploy.build.package.download
    app.binary = file.open
    app.save

    app_group = SimpleMDM::AppGroup.find(7_017)
    device_count = 0

    SimpleMDM::Device.all.each do |device|
      next unless deploy.includes_device_named?(device.device_name)
      next unless device.device_group_id.in?(app_group.device_group_ids)
      device.push_apps
      device.refresh
      device_count += 1
    end

    Slack.notify "Build of #{app.name} released to #{pluralize device_count, "device"} in #{deploy.timeslot.prefixes.to_sentence}."
    deploy.successful!
  end
end
