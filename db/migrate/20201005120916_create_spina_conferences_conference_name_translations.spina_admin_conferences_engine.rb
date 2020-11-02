# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200502133408)

class CreateSpinaConferencesConferenceNameTranslations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_conference_translations do |t|
      # Translated attribute(s)
      t.string :name

      t.string :locale, null: false
      t.references :spina_conferences_conference, null: false, foreign_key: true, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_conference_translations, :locale, name: :index_b1ed8f417185e6e49c50c1f2119c86824e3e3a22
    add_index :spina_conferences_conference_translations, %i[spina_conferences_conference_id locale],
              name: :index_0022b227e0816c00e61de831f2d638f1b305868e, unique: true
  end
end
