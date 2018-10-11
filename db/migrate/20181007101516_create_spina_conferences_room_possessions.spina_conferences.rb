# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180916135432)

class CreateSpinaConferencesRoomPossessions < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_conferences_room_possessions do |t|
      t.belongs_to :room, foreign_key: { to_table: :spina_conferences_rooms }
      t.belongs_to :conference,
                   foreign_key: { to_table: :spina_conferences_conferences }
    end
  end
end
