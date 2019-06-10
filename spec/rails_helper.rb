require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.order = :random

  config.use_transactional_fixtures = true

  config.expose_dsl_globally = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before :each, running_jobs: true do
    # Run enqueued jobs with the adapter set in config/environments/test.rb
    # rather than overriding with the TestAdapter.
    ActiveJob::Base.disable_test_adapter
  end

  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end

  config.before :each, logged_in: true do
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
  end
end
