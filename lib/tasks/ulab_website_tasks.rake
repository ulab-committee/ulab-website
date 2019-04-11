# frozen_string_literal: true

require 'resque/tasks'

task 'resque:setup' => :environment

namespace :ulab_website do
  desc 'Create translations for pages'
  task create_translations: :environment do
    Spina.locales.each do |locale|
      I18n.locale = locale
      Spina::Page.find_each do |page|
        page.title ||= page.title locale: I18n.default_locale
        page.save!
      end
    end
  end
end
