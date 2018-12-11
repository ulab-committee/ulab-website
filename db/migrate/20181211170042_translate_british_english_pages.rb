# frozen_string_literal: true

class TranslateBritishEnglishPages < ActiveRecord::Migration[5.2] # :nodoc:
  def up
    I18n.default_locale = :en
    Rake::Task[:'ulab_website:create_translations'].invoke
  end

  def down
    Spina::Page.find_each do |page|
      @translation = page.translations.find_by locale: :'en-GB'
      @translation&.destroy
    end
  end
end
