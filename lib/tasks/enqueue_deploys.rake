namespace :deploys do
  # Meant to run every 10 minutes with Heroku Scheduler
  desc 'Enqueue deploys that are due in the next 20 minutes'
  task enqueue: :environment do
    Deploy.enqueue_pending
  end
end
