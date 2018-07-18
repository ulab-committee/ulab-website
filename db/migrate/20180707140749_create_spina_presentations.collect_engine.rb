# This migration comes from collect_engine (originally 3)
class CreateSpinaPresentations < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_presentations do |t|
      t.string :title
      t.date :date
      t.time :start_time
      t.text :abstract
      t.string :type
      t.references :spina_conference

      t.timestamps null: false
    end
  end
end
