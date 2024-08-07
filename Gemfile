source 'https://rubygems.org'

ruby '2.7.8'

gem 'rails', '7.0.8.4'                     # Rails framework
gem 'zeitwerk', '~> 2.6'                   # Used for auto load of dependencies
gem 'pg', '~> 1.5'                         # Database for Active Record
gem 'sidekiq', '~> 5.0'                    # Background processor
gem 'puma', '~> 6.4'                       # Fast and concurrent web server
gem 'bootsnap', '~> 1.18', require: false  # Speed up Rails boot time
gem 'aws-sdk-s3', '~> 1.157', require: false # Upload files to S3
gem 'yt-auth', '~> 0.3.1'                  # Authenticate with Google
gem 'simplemdm', '~> 1.3'                  # Connect to SimpleMDM API
gem 'honeybadger', '~> 4.1'                # Log errors
gem 'rubyzip'                              # Extract Info.plist from build package
gem 'CFPropertyList', '~> 3.0'             # Parse Info.plist from build package

group :development, :test do
  gem 'rubocop'
  gem 'spring'                             # Speed up local development
end

group :test do
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'                        # Testing framework
  gem 'capybara'                           # Runs system tests
  gem 'selenium-webdriver'                 # Runs system tests
  gem 'webdrivers'                         # Runs system tests in Chrome
  gem 'simplecov'                          # Measure code coverage
end
