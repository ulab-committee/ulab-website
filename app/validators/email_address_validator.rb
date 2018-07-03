require 'mail'

class EmailAddressValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    return value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
  def validate_each(record, attribute, value)
    unless value.present? && self.class.compliant?(value)
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end
