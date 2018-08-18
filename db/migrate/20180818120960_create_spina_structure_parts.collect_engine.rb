# This migration comes from collect_engine (originally 7)
class CreateSpinaStructureParts < ActiveRecord::Migration[5.2]
  def change
    create_table :spina_urls do |t|
      t.string :content

      t.timestamps null: false
    end
    create_table :spina_email_addresses do |t|
      t.string :content

      t.timestamps null: false
    end
    create_table :spina_dates do |t|
      t.date :content

      t.timestamps null: false
    end
  end
end
