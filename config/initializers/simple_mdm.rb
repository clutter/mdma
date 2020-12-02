# typed: strict
SimpleMDM.api_key = Rails.application.credentials.dig :simple_mdm, :key
SimpleMDM.api_key ||= ENV['SIMPLEMDM_API_KEY']
