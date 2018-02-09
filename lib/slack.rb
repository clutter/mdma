require 'rest-client'

class Slack
  def self.notify(message)
    RestClient.post Rails.application.credentials.dig(:slack, :token_url), {'text' => message}.to_json, {content_type: :json, accept: :json}
  end
end
