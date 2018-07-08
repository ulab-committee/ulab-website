class FinishDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value > record.start_date
      record.errors[attribute] << (options[:message] || "is not after start date")
    end
  end
end