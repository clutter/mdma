require 'slack'

# Uploads a new binary to SimpleMDM to push to the appropriate devices.
class DeployJob < ActiveJob::Base
  queue_as :default

  def perform(deploy)
    upload_file deploy
    uploaded_devices = push_to_devices deploy
    message = "Build of #{app.name} released to "
    message << "#{uploaded_devices} in #{deploy.timeslot.prefixes.to_sentence}."
    Slack.notify message
    deploy.successful!
  end

private

  def upload_file(deploy)
    app = SimpleMDM::App.find(16_714)
    Slack.notify "Build of #{app.name} started."
    deploy.running!

    file = Tempfile.open ['package', '.ipa'], encoding: 'ASCII-8BIT'
    file.write deploy.build.package.download
    app.binary = file.open
    app.save
  end

  def push_to_devices(deploy)
    app_group = SimpleMDM::AppGroup.find(7_017)
    device_count = 0

    SimpleMDM::Device.all.each do |device|
      next unless deploy.includes_device_named?(device.device_name)
      next unless device.device_group_id.in?(app_group.device_group_ids)
      device.push_apps
      device.refresh
      device_count += 1
    end
    "#{device_count} #{'device'.pluralize device_count}"
  end
end
