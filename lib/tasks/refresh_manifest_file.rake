namespace :builds do
  # Meant to run every day with Heroku Scheduler
  desc 'Refresh the manifest file for a build since the URL expires weekly'
  task refresh_latest_manifest: :environment do
    if Time.now.wednesday? || Time.now.sunday? # Only run twice a week
      latest = Build.latest_deployed.first
      GenerateManifestJob.perform_later(latest) if latest
    end
  end
end
