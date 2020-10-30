# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420104603)

class CreateSpinaConferencesDietaryRequirementNameTranslations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_dietary_requirement_translations do |t|
      # Translated attribute(s)
      t.string :name

      t.string :locale, null: false
      t.references :spina_conferences_dietary_requirement, null: false, foreign_key: { on_delete: :cascade }, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_dietary_requirement_translations, :locale, name: :index_e52faf9b7cbf3a3d55057c84094a3a10b5de6fdd
    add_index :spina_conferences_dietary_requirement_translations, %i[spina_conferences_dietary_requirement_id locale],
              name: :index_70c4d45aefa2ef2619dd91b976391c1025d86e89, unique: true
  end
end
