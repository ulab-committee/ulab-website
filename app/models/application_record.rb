# frozen_string_literal: true

# Base record class for app
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
