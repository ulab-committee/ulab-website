web: bundle exec puma -C config/puma.rb
release: rake db:migrate
worker: env QUEUE=* bundle exec rake resque:work
