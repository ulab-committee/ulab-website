# frozen_string_literal: true

# Base helper included with all controllers
module ApplicationHelper
  def variant(image, options)
    super(image, process_options(options))
  end

  def svg(name)
    File.open("app/assets/images/#{name}.svg", 'rb') do |file|
      raw file.read # rubocop:disable Rails/OutputSafety
    end
  end

  private

  def process_options(options)
    options.each_with_object({}) do |option, processed_options|
      option_key, option_value = option
      case option_key
      when :resize then processed_options[:thumbnail] = option_value
      else processed_options[option_key] = option_value
      end
    end
  end
end
