# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180916135433)

class CreateSpinaConferencesRoomUses < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_conferences_room_uses do |t|
      t.belongs_to :room_possession,
                   foreign_key: { to_table: :spina_conferences_room_possessions }
      t.belongs_to :presentation_type,
                   foreign_key: { to_table: :spina_conferences_presentation_types }
    end
  end
end
