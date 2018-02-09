require 'rest-client'

class Slack
  def self.notify(message)
    credentials = Rails.application.credentials.dig(:slack, :token_url)
    RestClient.post credentials, { 'text' => message }.to_json, content_type: :json, accept: :json
  end
end
