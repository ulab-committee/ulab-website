# frozen_string_literal: true

require 'fileutils'

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

  desc 'Copy .env.sample to .env'
  task :copy_env do
    source = File.join(Rails.root, '.env.sample')
    dest = File.join(Rails.root, '.env')
    if File.file?(dest)
        puts 'Existing .env found! Moving to .env.old...'
        FileUtils.mv dest, File.join(Rails.root, '.env.old')
    end
    puts 'Copying .env.sample to .env...'
    FileUtils.cp source, dest
  end
end
