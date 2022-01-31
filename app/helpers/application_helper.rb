# frozen_string_literal: true

# Base helper included with all controllers
module ApplicationHelper
  def variant(image, options)
    super(image, process_options(options))
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end

  private

  def process_options(options)
    options.inject({}) do |processed_options, option|
      option_key, option_value = option
      case option_key
      when :resize then processed_options[:thumbnail] = option_value
      else processed_options[option_key] = option_value
      end
      processed_options
    end
  end
end
