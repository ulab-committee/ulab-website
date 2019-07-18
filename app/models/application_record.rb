# frozen_string_literal: true

# Base class from which models inherit
class ApplicationRecord < ActiveRecord::Base #:nodoc:
  self.abstract_class = true
end
