# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0.beta3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '>= 4.0.0.rc.3'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'hiredis', '~> 0.6.3'
gem 'redis', '~> 4.1'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

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
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
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

# Spina CMS
gem 'spina', github: 'SpinaCMS/Spina'

# Conferences plugin
gem 'spina-conferences', github: 'jmalcic/spina-conferences'

# S3
gem 'aws-sdk-s3', require: false

# Email obfuscation
gem 'actionview-encoded_mail_to'

# iCal events
gem 'icalendar'

# Internationalisation
gem 'rails-i18n', '~> 6.0.0.beta1'

# Job queueing
gem 'sidekiq'

# Production gems
gem 'barnes', '~> 0.0.7'
gem 'bugsnag', '~> 6.8'
gem 'dotenv-rails', '~> 2.7'
gem 'rack-timeout'
gem 'skylight', '~> 4.1'

# Image processing
gem 'image_processing', '~> 1.9'
gem 'ruby-vips', '~> 2.0'

# Instrumentation
gem 'tunemygc'
