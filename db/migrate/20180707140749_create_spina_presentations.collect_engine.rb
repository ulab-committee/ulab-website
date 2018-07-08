# This migration comes from collect_engine (originally 3)
class CreateSpinaPresentations < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_presentations do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :finish_time
      t.text :abstract
      t.references :spina_conference, foreign_key: true

      t.timestamps null: false
    end
  end
end
