# frozen_string_literal: true

# Base class from which mailers inherit
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
