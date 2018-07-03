class CreateSpinaPresentations < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_presentations do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :finish_time
      t.string :name
      t.string :institution
      t.string :email_address
      t.text :abstract

      t.timestamps null: false
    end
  end
end
