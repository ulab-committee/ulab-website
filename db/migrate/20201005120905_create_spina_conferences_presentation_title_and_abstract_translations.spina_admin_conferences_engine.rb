# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420105057)

class CreateSpinaConferencesPresentationTitleAndAbstractTranslations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_presentation_translations do |t|
      # Translated attribute(s)
      t.string :title
      t.text :abstract

      t.string :locale, null: false
      t.references :spina_conferences_presentation, null: false, foreign_key: { on_delete: :cascade }, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_presentation_translations, :locale, name: :index_0cda3821bc3be79968f9671e2a1d655e2307ad5b
    add_index :spina_conferences_presentation_translations, %i[spina_conferences_presentation_id locale],
              name: :index_a9e38adc19b163962a915fe8d3d1f2415f0c83a0, unique: true
  end
end
