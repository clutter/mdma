# typed: true
require 'rest-client'

# Slack.notify sends a notification to Slack about deploys
class Slack
  def self.notify(message)
    credentials = Rails.application.credentials.dig(:slack, :token_url)
    payload = { 'text' => message }
    payload['channel'] = ENV['SLACK_CHANNEL'] if ENV['SLACK_CHANNEL'].present?
    RestClient.post credentials, payload.to_json, content_type: :json, accept: :json
  end
end
