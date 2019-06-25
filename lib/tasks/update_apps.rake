namespace :app_groups do
  # Meant to run every night with Heroku Scheduler
  desc 'Sends a request to all phones in the app group to update to the latest version of the app'
  task update_apps: :environment do
    SimpleMDM::AppGroup.new(id: ENV['MDMA_APP_GROUP_ID']).update_apps
  end
end
