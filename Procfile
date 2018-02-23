web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -t 25 -c 3
release: bundle exec rails db:migrate
