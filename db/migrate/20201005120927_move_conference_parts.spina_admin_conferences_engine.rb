# frozen_string_literal: true

class MoveConferenceParts < ActiveRecord::Migration[6.0] # rubocop:disable Metrics/ClassLength, Style/Documentation
  def up
    insert <<-SQL.squish, 'Create events', nil, nil, nil
      WITH event_structure_items_with_parts AS (
        SELECT DISTINCT
          spina_structure_items.id AS structure_item_id,
          pageable_id AS conference_id,
          structure_id,
          start_times.content AS start_time,
          names.content AS title,
          locations.content AS location,
          descriptions.content AS description,
          names.locale AS locale,
          start_times.id AS start_time_id,
          names.id AS title_translation_id,
          locations.id AS location_translation_id,
          descriptions.id AS description_translation_id
          FROM spina_conferences_parts
            INNER JOIN spina_structure_items ON partable_id = structure_id AND partable_type = 'Spina::Structure'
            LEFT JOIN (
              SELECT spina_conferences_time_parts.id AS id, spina_conferences_time_parts.content AS content, structure_item_id
                FROM spina_structure_parts
                  INNER JOIN spina_conferences_time_parts
                    ON structure_partable_id = spina_conferences_time_parts.id
                      AND structure_partable_type = 'Spina::Admin::Conferences::TimePart'
                      AND spina_structure_parts.name = 'start_time'
            ) AS start_times ON start_times.structure_item_id = spina_structure_items.id
            LEFT JOIN (
              SELECT
                spina_lines.id AS id, content, locale, structure_item_id
                FROM spina_structure_parts
                  INNER JOIN spina_lines
                    ON structure_partable_id = spina_lines.id
                      AND structure_partable_type = 'Spina::Line'
                      AND spina_structure_parts.name = 'name'
                  INNER JOIN spina_line_translations
                    ON spina_line_id = spina_lines.id
                WHERE content IS NOT NULL
            ) AS names ON names.structure_item_id = spina_structure_items.id
            LEFT JOIN (
              SELECT spina_lines.id AS id, content, locale, structure_item_id
                FROM spina_structure_parts
                  INNER JOIN spina_lines
                    ON structure_partable_id = spina_lines.id
                      AND structure_partable_type = 'Spina::Line'
                      AND spina_structure_parts.name = 'location'
                  INNER JOIN spina_line_translations
                    ON spina_line_id = spina_lines.id
                WHERE content IS NOT NULL
            ) AS locations ON locations.structure_item_id = spina_structure_items.id
            LEFT JOIN (
              SELECT spina_texts.id AS id, content, locale, structure_item_id
                FROM spina_structure_parts
                  INNER JOIN spina_texts
                    ON structure_partable_id = spina_texts.id
                      AND structure_partable_type = 'Spina::Text'
                      AND spina_structure_parts.name = 'description'
                  INNER JOIN spina_text_translations
                    ON spina_text_id = spina_texts.id
                WHERE content IS NOT NULL
            ) AS descriptions ON descriptions.structure_item_id = spina_structure_items.id
          WHERE pageable_type = 'Spina::Admin::Conferences::Conference'
            AND spina_conferences_parts.name IN ('meetings', 'socials')
            AND names.locale = locations.locale
            AND locations.locale = descriptions.locale
      ), untranslated_event_structure_items_with_parts AS (
        SELECT DISTINCT ON (structure_item_id) structure_item_id, start_time, conference_id
          FROM event_structure_items_with_parts
      ), events AS (
        INSERT INTO spina_conferences_events (start_datetime, finish_datetime, conference_id, created_at, updated_at)
          SELECT start_time, start_time + interval '1 hour', conference_id, current_timestamp, current_timestamp
            FROM untranslated_event_structure_items_with_parts
          RETURNING id
      ), event_translations AS (
        INSERT INTO spina_conferences_event_translations
          (name, description, location, locale, spina_conferences_event_id, created_at, updated_at) 
          SELECT DISTINCT ON (event_structure_items_with_parts_and_indices.structure_item_id, locale)
            title, description, location, locale, structure_item_events.id, current_timestamp, current_timestamp
            FROM (
              SELECT structure_item_id, row_number() OVER (ORDER BY structure_item_id) AS index
                FROM untranslated_event_structure_items_with_parts
            ) AS event_structure_items_with_parts_and_indices
              INNER JOIN (SELECT id, row_number() OVER (ORDER BY id) AS index FROM events) AS structure_item_events
                ON structure_item_events.index = event_structure_items_with_parts_and_indices.index
              INNER JOIN event_structure_items_with_parts
                ON event_structure_items_with_parts.structure_item_id = event_structure_items_with_parts_and_indices.structure_item_id
      ), line_translations AS (
        DELETE FROM spina_line_translations
          USING event_structure_items_with_parts
          WHERE id IN (title_translation_id, location_translation_id)
          RETURNING spina_line_id
      ), lines AS (
        DELETE FROM spina_lines USING line_translations WHERE spina_line_id = id RETURNING id
      ), text_translations AS (
        DELETE FROM spina_text_translations
          USING event_structure_items_with_parts
          WHERE id = description_translation_id
          RETURNING spina_text_id
      ), texts AS (
        DELETE FROM spina_texts USING text_translations WHERE spina_text_id = id RETURNING id
      ), times AS (
        DELETE FROM spina_conferences_time_parts USING event_structure_items_with_parts WHERE id = start_time_id RETURNING id
      ), structure_parts AS (
        DELETE FROM spina_structure_parts
          USING lines, texts, times
          WHERE
            (structure_partable_id = lines.id AND structure_partable_type = 'Spina::Line')
            OR (structure_partable_id = texts.id AND structure_partable_type = 'Spina::Text')
            OR (structure_partable_id = times.id AND structure_partable_type = 'Spina::Admin::Conferences::TimePart')
          RETURNING structure_item_id
      ), structure_items AS (
        DELETE FROM spina_structure_items USING structure_parts WHERE structure_item_id = spina_structure_items.id RETURNING structure_id
      ), structures AS (
        DELETE FROM spina_structures USING structure_items WHERE structure_id = spina_structures.id
      )
      DELETE FROM spina_conferences_parts
        USING event_structure_items_with_parts WHERE partable_id = structure_id AND partable_type = 'Spina::Structure'
    SQL
  end

  def down
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    delete <<-SQL.squish, 'Create events', binds
      WITH
        conferences AS (SELECT DISTINCT ON (conference_id) conference_id AS id FROM spina_conferences_events),
        structures AS (
          INSERT INTO spina_structures (created_at, updated_at) SELECT current_timestamp, current_timestamp FROM conferences RETURNING id
        ), parts AS (
          INSERT INTO spina_conferences_parts (title, name, partable_type, partable_id, pageable_type, pageable_id)
            SELECT
              'Events', 'events', 'Spina::Structure', structures_with_indices.id, 'Spina::Admin::Conferences::Conference', conferences.id
              FROM (SELECT id, row_number() OVER (ORDER BY id) AS index FROM structures) AS structures_with_indices
                INNER JOIN (SELECT id, row_number() OVER (ORDER BY id) AS index FROM conferences) AS conferences_with_indices USING (index)
      ), events AS (
        SELECT spina_conferences_events.id AS id, name, description, location, locale, start_datetime, conference_id
          FROM spina_conferences_events
            INNER JOIN spina_conferences_event_translations ON spina_conferences_event_id = spina_conferences_events.id AND locale = $1
      ), structure_items AS (
        INSERT INTO spina_structure_items (structure_id, position, created_at, updated_at)
          SELECT structures_with_indices.id, events_with_indices.index, current_timestamp, current_timestamp
            FROM (SELECT conference_id, row_number() over (ORDER BY id) AS index FROM events) AS events_with_indices
              INNER JOIN (SELECT id, row_number() OVER (ORDER BY id) AS index FROM conferences) AS conferences_with_indices
                ON conference_id = conferences_with_indices.id
              INNER JOIN (SELECT id, row_number() OVER (ORDER BY id) AS index FROM structures) AS structures_with_indices
                ON conferences_with_indices.index = structures_with_indices.index
          RETURNING id
      ), line_parts AS (
        SELECT id AS event_id, name AS content, 'Spina::Line' AS type, 'Title' AS title FROM events
          UNION ALL SELECT id, location, 'Spina::Line', 'Location' FROM events
          ORDER BY event_id, title
      ), text_parts AS (
        SELECT id AS event_id, name AS content, 'Spina::Text' AS type, 'Description' AS title FROM events ORDER BY event_id, title
      ), datetime_parts AS (
        SELECT id AS event_id, start_datetime AS content, 'Spina::Admin::Conferences::TimePart' AS type, 'Start time' AS title
          FROM events
          ORDER BY event_id, title
      ), lines AS (
        INSERT INTO spina_lines (created_at, updated_at) SELECT current_timestamp, current_timestamp FROM line_parts RETURNING id
      ), line_translations AS (
        INSERT INTO spina_line_translations (spina_line_id, locale, content, created_at, updated_at)
          SELECT lines_with_indices.id, $1, content, current_timestamp, current_timestamp
            FROM (SELECT content, type, row_number() OVER (ORDER BY event_id, title) AS index FROM line_parts) AS line_parts_with_indices
              INNER JOIN (SELECT id, row_number() OVER (ORDER BY id) AS index FROM lines) AS lines_with_indices USING (index)
          RETURNING id
      ), texts AS (
        INSERT INTO spina_texts (created_at, updated_at)
          SELECT current_timestamp, current_timestamp FROM text_parts ORDER BY event_id, title
          RETURNING id
      ), text_translations AS (
        INSERT INTO spina_text_translations (spina_text_id, locale, content, created_at, updated_at)
          SELECT texts_with_indices.id, $1, content, current_timestamp, current_timestamp
            FROM (SELECT content, type, row_number() OVER (ORDER BY event_id, title) AS index FROM text_parts) AS text_parts_with_indices
              INNER JOIN (SELECT id, row_number() OVER (ORDER BY id) AS index FROM lines) AS texts_with_indices USING (index)
          RETURNING id
      ), times AS (
        INSERT INTO spina_conferences_time_parts (content, created_at, updated_at)
          SELECT content, current_timestamp, current_timestamp FROM datetime_parts
          RETURNING id
      ), structure_parts_to_insert AS (
        SELECT partable_id, type, title, event_id
          FROM (SELECT id as partable_id, row_number() OVER (ORDER BY id) AS index FROM lines) AS lines_with_indices
            INNER JOIN (
              SELECT type, title, event_id, row_number() OVER (ORDER BY event_id, title) AS index FROM line_parts WHERE type = 'Spina::Line'
            ) AS line_parts_with_indices USING (index)
        UNION ALL
          SELECT partable_id, type, title, event_id
            FROM (SELECT id as partable_id, row_number() OVER (ORDER BY id) AS index FROM texts) AS texts_with_indices
              INNER JOIN (
                SELECT type, title, event_id, row_number() OVER (ORDER BY event_id, title) AS index
                  FROM text_parts
                  WHERE type = 'Spina::Text'
              ) AS text_parts_with_indices USING (index)
        UNION ALL
          SELECT partable_id, type, title, event_id
            FROM (SELECT id as partable_id, row_number() OVER (ORDER BY id) AS index FROM times) AS times_with_indices
              INNER JOIN (
                SELECT type, title, event_id, row_number() OVER (ORDER BY event_id, title) AS index
                  FROM datetime_parts
                  WHERE type = 'Spina::Text'
              ) AS time_parts_with_indices USING (index)
      ), structure_parts AS (
        INSERT INTO spina_structure_parts
          (structure_item_id, structure_partable_id, structure_partable_type, name, title, created_at, updated_at) 
          SELECT
            structure_items_with_indices.id, partable_id, type, replace(lower(title), '\W', '_'), title, current_timestamp,
            current_timestamp
            FROM structure_parts_to_insert
              INNER JOIN (SELECT id, row_number() OVER (ORDER BY id) AS index FROM events) AS events_with_indices ON event_id = events.id
              INNER JOIN (SELECT id, row_number() OVER (ORDER BY id) AS index FROM structure_items) AS structure_items_with_indices
                USING (index)
      ), deleted_events AS (
        DELETE FROM spina_conferences_events RETURNING id
      )
      DELETE FROM spina_conferences_event_translations USING deleted_events WHERE spina_conferences_event_id = deleted_events.id
    SQL
  end
end
