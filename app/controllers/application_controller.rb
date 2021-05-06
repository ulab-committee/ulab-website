# frozen_string_literal: true

# Base class from which controllers inherit
class ApplicationController < ActionController::Base
  def default_url_options
    { host: 'ulab.org.uk' }
  end
end
