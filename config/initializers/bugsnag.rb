# frozen_string_literal: true

Bugsnag.configure do |config|
  config.api_key = Rails.application.credentials.dig(:bugsnag, :api_key)
  config.app_version = ENV['HEROKU_RELEASE_VERSION']
  config.notify_release_stages = %w[staging production]
end
