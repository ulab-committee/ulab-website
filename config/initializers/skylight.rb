# frozen_string_literal: true

# Background job profiling
Rails.application.config.skylight.probes << 'active_job'
