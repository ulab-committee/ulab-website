# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'
# Use Redis adapter to run Action Cable in production
gem 'hiredis', '~> 0.6.3'
gem 'redis', '~> 4.6'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console'
  # anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.8'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'rubocop', '~> 1.42'
  gem 'rubocop-performance', '~> 1.14'
  gem 'rubocop-rails', '~> 2.14'
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'simplecov'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Primer Theme plugin
gem 'spina-conferences-primer_theme-fork', '1.0.3', require: 'spina/conferences/primer_theme'

# S3
gem 'aws-sdk-s3', require: false

# Email obfuscation
gem 'actionview-encoded_mail_to'

# Internationalisation
gem 'rails-i18n', '~> 7.0'

# Job queueing
gem 'sidekiq'

gem 'bugsnag', '~> 6.24'
gem 'skylight', '~> 5.3'

# Production gems
group :production, :staging do
  gem 'barnes', '~> 0.0.9'
  gem 'dotenv-rails', '~> 2.7'
  gem 'rack-timeout'
end

# Show maintenance mode screen
gem 'turnout'
