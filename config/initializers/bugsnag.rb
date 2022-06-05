# frozen_string_literal: true

Bugsnag.configure do |config|
  config.api_key = Rails.application.credentials.dig(:bugsnag, :api_key)
  config.app_version = ENV.fetch('HEROKU_RELEASE_VERSION', nil)
  config.notify_release_stages = %w[staging production]
end
