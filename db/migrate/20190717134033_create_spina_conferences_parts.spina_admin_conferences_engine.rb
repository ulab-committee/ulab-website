# This migration comes from spina_conferences (originally 20190622131423)
class CreateSpinaConferencesParts < ActiveRecord::Migration[6.0]
  def change
    create_table :spina_conferences_parts do |t|
      t.string :title
      t.string :name
      t.references :partable, polymorphic: true, index: false
      t.references :pageable, polymorphic: true, index: false
    end
  end
end
