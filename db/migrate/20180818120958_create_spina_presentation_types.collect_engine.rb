# This migration comes from collect_engine (originally 5)
class CreateSpinaPresentationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_presentation_types do |t|
      t.string :name
      t.interval :duration

      t.timestamps null: false
    end
  end
end
