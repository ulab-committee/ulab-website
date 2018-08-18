# This migration comes from collect_engine (originally 4)
class CreateSpinaPresentations < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_presentations do |t|
      t.string :title
      t.date :date
      t.time :start_time
      t.text :abstract
      t.references :spina_conference
      t.references :spina_presentation_type

      t.timestamps null: false
    end
  end
end
