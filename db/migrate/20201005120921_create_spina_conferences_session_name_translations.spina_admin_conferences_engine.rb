# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200510125131)

class CreateSpinaConferencesSessionNameTranslations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_session_translations do |t|
      # Translated attribute(s)
      t.string :name

      t.string :locale, null: false
      t.references :spina_conferences_session, null: false, foreign_key: true, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_session_translations, :locale, name: :index_spina_conferences_session_translations_on_locale
    add_index :spina_conferences_session_translations, %i[spina_conferences_session_id locale],
              name: :index_7843e68c4bf93df06700ea7f68c4765ef004169a, unique: true
  end
end
