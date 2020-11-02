# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200802184921)

class CreateSpinaConferencesEventNameDescriptionAndLocationTranslations < ActiveRecord::Migration[6.0] # rubocop:disable Style/Documentation
  def change # rubocop:disable Metrics/MethodLength
    create_table :spina_conferences_event_translations do |t|
      # Translated attribute(s)
      t.string :name
      t.text :description
      t.string :location

      t.string :locale, null: false
      t.references :spina_conferences_event, null: false, foreign_key: true, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_event_translations, :locale, name: :index_spina_conferences_event_translations_on_locale
    add_index :spina_conferences_event_translations, %i[spina_conferences_event_id locale],
              name: :index_a26428290c005036f14c7c9cab5f5a91289e46e0, unique: true
  end
end
