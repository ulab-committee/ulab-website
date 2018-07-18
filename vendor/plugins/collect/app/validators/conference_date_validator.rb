class ConferenceDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.conference.dates.include? value
      record.errors[attribute] << (options[:message] || "is not during the conference")
    end
  end
end