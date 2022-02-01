# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UlabWebsite
  class Application < Rails::Application # :nodoc:
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.time_zone = 'London'

    config.skylight.environments << 'staging'
    config.skylight.probes += %w[redis active_job]

    config.active_storage.resolve_model_to_route = :rails_storage_proxy

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers -- all .rb files in that directory are
    # automatically loaded after loading the framework and any gems in your application.
  end
end
