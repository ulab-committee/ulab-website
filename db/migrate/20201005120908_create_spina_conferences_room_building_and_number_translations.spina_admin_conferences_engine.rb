# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420105458)

class CreateSpinaConferencesRoomBuildingAndNumberTranslations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_room_translations do |t|
      # Translated attribute(s)
      t.string :building
      t.string :number

      t.string :locale, null: false
      t.references :spina_conferences_room, null: false, foreign_key: { on_delete: :cascade }, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_room_translations, :locale, name: :index_spina_conferences_room_translations_on_locale
    add_index :spina_conferences_room_translations, %i[spina_conferences_room_id locale],
              name: :index_a83edb40b92a36d42b882b3a9adf6d2be543dee7, unique: true
  end
end
