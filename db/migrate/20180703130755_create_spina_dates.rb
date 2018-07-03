class CreateSpinaDates < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_dates do |t|
      t.date :content

      t.timestamps null: false
    end
  end
end
