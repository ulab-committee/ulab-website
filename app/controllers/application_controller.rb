# frozen_string_literal: true

# Base class from which controllers inherit
class ApplicationController < ActionController::Base
  def default_url_options
    { host: 'www.ulab.org.uk' }
  end
end
