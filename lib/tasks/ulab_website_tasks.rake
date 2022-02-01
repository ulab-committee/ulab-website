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
  task copy_env: :environment do
    source = Rails.root.join('.env.sample')
    dest = Rails.root.join('.env')
    if File.file?(dest)
      puts 'Existing .env found! Moving to .env.old...'
      FileUtils.mv dest, Rails.root.join('.env.old')
    end
    puts 'Copying .env.sample to .env...'
    FileUtils.cp source, dest
  end
end

# Override cssbundling task

Rake::Task['css:build'].clear
namespace :css do
  desc 'Build your CSS bundle'
  task build: :environment do
    unless system 'yarn install'
      raise 'cssbundling-rails: Command css:build failed, ensure yarn is installed and `yarn build:css` runs without errors'
    end

    system "yarn run sass --load-path=#{Rails.root.join('app/assets/stylesheets')} --load-path=#{Spina::Conferences::PrimerTheme::Engine.root.join('app/assets/stylesheets')} --load-path=node_modules #{Spina::Conferences::PrimerTheme::Engine.root.join('app/assets/stylesheets/spina/conferences/primer_theme/application.sass')} #{Rails.root.join('app/assets/builds/spina/conferences/primer_theme/application.css')} --no-source-map" # rubocop:disable Layout/LineLength
  end
end

Rake::Task['assets:precompile'].enhance(['css:build']) if Rake::Task.task_defined?('assets:precompile')

if Rake::Task.task_defined?('test:prepare')
  Rake::Task['test:prepare'].enhance(['css:build'])
elsif Rake::Task.task_defined?('db:test:prepare')
  Rake::Task['db:test:prepare'].enhance(['css:build'])
end
