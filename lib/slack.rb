require 'rest-client'

class Slack
  def self.notify(message)
    RestClient.post "https://hooks.slack.com/services/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", {'text' => message}.to_json, {content_type: :json, accept: :json}
  end
end

