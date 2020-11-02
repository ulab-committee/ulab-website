# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420104740)

class CreateSpinaConferencesInstitutionNameAndCityTranslations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_institution_translations do |t|
      # Translated attribute(s)
      t.string :name
      t.string :city

      t.string :locale, null: false
      t.references :spina_conferences_institution, null: false, foreign_key: { on_delete: :cascade }, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_institution_translations, :locale, name: :index_9bff91c74e064cdc801502a3787ebe9a10fdecd1
    add_index :spina_conferences_institution_translations, %i[spina_conferences_institution_id locale],
              name: :index_28cf5cb308f9303c2ac50856f314ece46e11d90e, unique: true
  end
end
