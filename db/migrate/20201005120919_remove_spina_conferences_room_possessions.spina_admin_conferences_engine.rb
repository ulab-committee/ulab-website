# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200502183719)

class RemoveSpinaConferencesRoomPossessions < ActiveRecord::Migration[6.0] # :nodoc:
  def up
    add_reference :spina_conferences_room_uses, :room, foreign_key: { to_table: :spina_conferences_rooms }
    add_timestamps :spina_conferences_room_uses, null: true
    update_room_uses_with_room_id
    remove_reference :spina_conferences_room_uses, :room_possession
    drop_table :spina_conferences_room_possessions
    change_column_null :spina_conferences_room_uses, :created_at, false
    change_column_null :spina_conferences_room_uses, :updated_at, false
  end

  def down
    remove_timestamps :spina_conferences_room_uses
    create_room_possessions_table
    add_reference :spina_conferences_room_uses, :room_possession, foreign_key: { to_table: :spina_conferences_room_possessions }
    insert_room_possessions
    update_room_uses_with_room_possession_id
    remove_reference :spina_conferences_room_uses, :room
  end

  private

  def create_room_possessions_table
    create_table 'spina_conferences_room_possessions' do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.references :room, foreign_key: { to_table: :spina_conferences_rooms }
      t.references :conference, foreign_key: { to_table: :spina_conferences_conferences }
    end
  end

  def update_room_uses_with_room_id
    update <<-SQL.squish, 'Update room uses'
      UPDATE spina_conferences_room_uses
        SET (room_id, created_at, updated_at) = (spina_conferences_room_possessions.room_id, current_timestamp, current_timestamp)
        FROM spina_conferences_room_possessions
          WHERE spina_conferences_room_possessions.id = spina_conferences_room_uses.room_possession_id
    SQL
  end

  def insert_room_possessions
    insert <<-SQL.squish, 'Add room possessions'
      INSERT INTO spina_conferences_room_possessions (room_id, conference_id)
        SELECT DISTINCT spina_conferences_room_uses.room_id, spina_conferences_presentation_types.conference_id
          FROM spina_conferences_room_uses
            INNER JOIN spina_conferences_presentation_types
              ON spina_conferences_presentation_types.id = spina_conferences_room_uses.presentation_type_id
    SQL
  end

  def update_room_uses_with_room_possession_id
    update <<-SQL.squish, 'Add references to room uses'
      UPDATE spina_conferences_room_uses SET room_possession_id = spina_conferences_room_possessions.id
        FROM spina_conferences_room_possessions
          INNER JOIN spina_conferences_presentation_types USING (conference_id)
          WHERE spina_conferences_room_possessions.room_id = spina_conferences_room_uses.room_id
            AND spina_conferences_room_possessions.conference_id = spina_conferences_presentation_types.conference_id
    SQL
  end
end
