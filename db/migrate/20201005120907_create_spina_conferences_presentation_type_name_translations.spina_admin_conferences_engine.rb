# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420105201)

class CreateSpinaConferencesPresentationTypeNameTranslations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_presentation_type_translations do |t|
      # Translated attribute(s)
      t.string :name

      t.string :locale, null: false
      t.references :spina_conferences_presentation_type, null: false, foreign_key: { on_delete: :cascade }, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_presentation_type_translations, :locale, name: :index_22c39c0f300797c95ab75d46960dc27730d2065f
    add_index :spina_conferences_presentation_type_translations, %i[spina_conferences_presentation_type_id locale],
              name: :index_fa3b8cb99b12895308e3fc943d6db212ce4408d0, unique: true
  end
end
