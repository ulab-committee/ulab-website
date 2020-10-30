# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200502183409)

class SetNameForSpinaConferencesConferences < ActiveRecord::Migration[6.0] # :nodoc:
  def up
    add_translations
  end

  def down
    set_institution_from_room
    delete_translations
  end

  private

  def set_institution_from_room
    update <<-SQL.squish, 'Set institution from room'
      UPDATE spina_conferences_conferences SET (institution_id) = (
        SELECT spina_conferences_rooms.institution_id
          FROM spina_conferences_presentation_types
            INNER JOIN spina_conferences_room_uses ON spina_conferences_presentation_types.id = presentation_type_id
            INNER JOIN spina_conferences_room_possessions ON spina_conferences_room_possessions.id = room_possession_id
            INNER JOIN spina_conferences_rooms ON spina_conferences_rooms.id = room_id
          WHERE spina_conferences_conferences.id = spina_conferences_presentation_types.conference_id
          ORDER BY room_id
          LIMIT 1
      )
    SQL
  end

  def delete_translations
    delete <<-SQL.squish, 'Delete translations'
      DELETE FROM spina_conferences_conference_translations
    SQL
  end

  def add_translations
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Add translations', nil, nil, nil, binds
      INSERT INTO spina_conferences_conference_translations (locale, spina_conferences_conference_id, name, created_at, updated_at)
        SELECT $1, spina_conferences_conferences.id,
               concat_ws(' ', spina_conferences_institution_translations.name, date_part('year', lower(dates))),
               spina_conferences_conferences.created_at, spina_conferences_conferences.updated_at
          FROM spina_conferences_conferences
            INNER JOIN spina_conferences_institution_translations ON spina_conferences_institution_id = institution_id AND locale = $1
    SQL
  end
end
