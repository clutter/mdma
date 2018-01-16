namespace :builds do
  # Meant to run every 10 minutes with Heroku Scheduler
  desc "Enqueue builds that are due in the next 10 minutes"
  task :enqueue => :environment do
    Build.scheduled.where('deploy_at < ?', 12.minutes.from_now).find_each do |build|
      build.enqueue
    end
  end
end
