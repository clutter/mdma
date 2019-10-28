require 'slack'

# Uploads a new binary to SimpleMDM to push to the appropriate devices.
class DeployJob < ActiveJob::Base
  queue_as :default

  def perform(deploy)
    upload_file deploy
    device_count = push_to_devices deploy
    notify_slack deploy, device_count
    deploy.successful!
  rescue *connection_errors => error
    perform_again deploy, error
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

  # Sleeps for a while and retries twice, in case a connection error has occurred.
  def perform_again(deploy, error)
    @retries_so_far ||= -1
    @retries_so_far += 1
    if @retries_so_far < 2
      Rails.logger.info "Retry #{@retries_so_far} after #{error}"
      sleep 3 + (5 * @retries_so_far)
      perform deploy
    else
      Honeybadger.notify "Release #{deploy.build.version} failed (#{error}: #{error.try(:http_body)})"
      deploy.failed!
    end
  end

  # Returns a list of connection errors worth retrying at least once.
  def connection_errors
    [
      OpenSSL::SSL::SSLError, Errno::ETIMEDOUT, Errno::EHOSTUNREACH, Errno::ENETUNREACH, Errno::ECONNRESET,
      SocketError, Net::OpenTimeout, Net::HTTPServerError, OpenSSL::SSL::SSLErrorWaitReadable, RestClient::Exception
    ]
  end

  def notify_slack(deploy, device_count)
    app_name = "#{app.name} (#{deploy.build.version})"
    Slack.notify "#{app_name} released to #{device_count} #{'device'.pluralize device_count}."
    notes = fetch_notes(deploy) if github_project.present?
    Slack.notify notes if notes.present?
  end

  def fetch_notes(deploy)
    github_username = Rails.application.credentials.dig :github, :username
    github_token = Rails.application.credentials.dig :github, :token
    url = "api.github.com/repos/#{github_project}/releases/tags/#{deploy.build.version}"
    response = RestClient.get "https://#{github_username}:#{github_token}@#{url}"
    JSON(response.body)['body'] if response.code == 200
  rescue RestClient::Exception => error
    Honeybadger.notify "Release #{deploy.build.version} was not found on GitHub (#{error})"
  end

  def github_project
    ENV['GITHUB_PROJECT']
  end

  def app
    @app ||= SimpleMDM::App.find(ENV['MDMA_APP_ID'])
  end

  def app_group
    @app_group ||= SimpleMDM::AppGroup.find(ENV['MDMA_APP_GROUP_ID'])
  end

  def should_push?(deploy, device)
    device.device_name &&
      device.device_group_id.in?(app_group.device_group_ids) &&
      device.status == 'enrolled'
  end
end
