namespace :devices do
  # Meant to run every day with Heroku Scheduler
  desc 'Fetch the list of the devices to check the version of the installed app'
  task fetch: :environment do
    FetchDevicesJob.perform_later
  end
end
