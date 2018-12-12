# frozen_string_literal: true

# Base mailer class for app
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
