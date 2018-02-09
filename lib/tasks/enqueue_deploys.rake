namespace :deploys do
  # Meant to run every 10 minutes with Heroku Scheduler
  desc "Enqueue deploys that are due in the next 20 minutes"
  task enqueue: :environment do
    Deploy.with_associations.scheduled.find_each do |deploy|
      deploy.enqueue if deploy.timestamp < 20.minutes.from_now
    end
  end
end
