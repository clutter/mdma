require 'slack'

# Announces on Slack the creation of a new build.
class AnnounceBuildJob < ActiveJob::Base
  queue_as :default

  def perform(build)
    return if ENV['SLACK_BUILD_CHANNEL'].blank?

    app_name = "#{app.name} (#{build.version})"
    Slack.notify "A new build of #{app_name} is available.", channel: ENV['SLACK_BUILD_CHANNEL']
  end

private

  def app
    @app ||= SimpleMDM::App.find(ENV['MDMA_APP_ID'])
  end
end
