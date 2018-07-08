# This migration comes from collect_engine (originally 1)
class CreateSpinaConferences < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_conferences do |t|
      t.date :start_date
      t.date :finish_date
      t.string :city
      t.string :institution

      t.timestamps null: false
    end
  end
end
