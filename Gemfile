source 'https://rubygems.org'

ruby '2.5.5'

gem 'rails', '~> 5.2.2'                    # Rails framework
gem 'pg', '~> 0.18'                        # Database for Active Record
gem 'sidekiq', '~> 5.0'                    # Background processor
gem 'puma', '~> 3.12'                      # Fast and concurrent web server
gem 'bootsnap', '>= 1.1.0', require: false # Speed up Rails boot time
gem 'aws-sdk-s3', '~> 1.23', require: false # Upload files to S3
gem 'yt-auth', '~> 0.3.1'                  # Authenticate with Google
gem 'simplemdm', '~> 1.3'                  # Connect to SimpleMDM API
gem 'honeybadger', '~> 4.1'                # Log errors
gem 'rubyzip'                              # Extract Info.plist from build package
gem 'CFPropertyList', '~> 3.0'             # Parse Info.plist from build package

group :development, :test do
  gem 'pry-byebug', '~> 3.6'               # Debugger with 'next' option
  gem 'spring'                             # Speed up local development
end

group :test do
  gem 'rspec-rails', '>= 3.7', '< 4.0'     # Testing framework
  gem 'capybara', '>= 2.15', '< 4.0'       # Runs system tests
  gem 'selenium-webdriver'                 # Runs system tests
  gem 'chromedriver-helper'                # Runs system tests in Chrome
  gem 'simplecov'                          # Measure code coverage
end
