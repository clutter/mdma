require 'slack'

# Uploads a new binary to SimpleMDM to push to the appropriate devices.
class DeployJob < ActiveJob::Base
  queue_as :default

  def perform(deploy)
    upload_file deploy
    device_count = push_to_devices deploy
    notify_slack deploy, device_count
    deploy.successful!
  rescue StandardError => error
    Honeybadger.notify "Release #{deploy.build.version} failed (#{error})"
    deploy.failed!
  end

private

  def upload_file(deploy)
    deploy.running!

    file = Tempfile.open ['package', '.ipa'], encoding: 'ASCII-8BIT'
    file.write deploy.build.package.download
    app.binary = file.open
    app.save
  end

  def push_to_devices(deploy)
    device_count = 0
    SimpleMDM::Device.all.each do |device|
      next unless should_push?(deploy, device)
      device.push_apps
      device.refresh
      device_count += 1
    end
    device_count
  end

  def notify_slack(deploy, device_count)
    slots = deploy.timeslot.prefixes.to_sentence
    app_name = "#{app.name} (#{deploy.build.version})"
    Slack.notify "#{app_name} released to #{device_count} #{'device'.pluralize device_count} in #{slots}."
    if deploy.first?
      notes = fetch_notes(deploy)
      Slack.notify notes if notes.present?
    end
  end

  def fetch_notes(deploy)
    github_username = Rails.application.credentials.dig :github, :username
    github_token = Rails.application.credentials.dig :github, :token
    url = "api.github.com/repos/clutter/clutter-ios-wms/releases/tags/#{deploy.build.version}"
    response = RestClient.get "https://#{github_username}:#{github_token}@#{url}"
    JSON(response.body)['body'] if response.code == 200
  rescue RestClient::Exception => error
    Honeybadger.notify "Release #{deploy.build.version} was not found on GitHub (#{error})"
  end

  def app
    @app ||= SimpleMDM::App.find(ENV['MDMA_APP_ID'])
  end

  def app_group
    @app_group ||= SimpleMDM::AppGroup.find(ENV['MDMA_APP_GROUP_ID'])
  end

  def should_push?(deploy, device)
    deploy.includes_device_named?(device.device_name) && device.device_group_id.in?(app_group.device_group_ids)
  end
end
