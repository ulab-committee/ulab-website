# frozen_string_literal: true

class SetDefaultLocale < ActiveRecord::Migration[5.2] # :nodoc:
  def change
    I18n.default_locale = :'en-GB'
    Rake::Task[:'spina:update_translations'].invoke
  end
end
