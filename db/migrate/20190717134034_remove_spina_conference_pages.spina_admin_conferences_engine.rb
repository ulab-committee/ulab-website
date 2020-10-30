# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20190701174807)

class RemoveSpinaConferencePages < ActiveRecord::Migration[6.0] #:nodoc:
  def up
    insert <<-SQL, 'Insert conferences parts'
      WITH parts AS (
        SELECT
          title,
          name,
          page_partable_id, page_partable_type,
          spina_conferences_conferences.id AS pageable_id,
          page_partable_type AS pageable_type
          FROM spina_conferences_conferences
            INNER JOIN spina_conferences_conference_page_parts
              ON conference_page_partable_id = spina_conferences_conferences.id
              AND conference_page_partable_type = 'Spina::Conferences::Conference'
            INNER JOIN spina_page_parts ON conference_page_id = page_id
        UNION
          SELECT
            spina_page_parts.title, name, page_partable_id, page_partable_type, spina_conferences_presentations.id, page_partable_type
            FROM spina_conferences_presentations
              INNER JOIN spina_conferences_conference_page_parts
                ON conference_page_partable_id = spina_conferences_presentations.id
                AND conference_page_partable_type = 'Spina::Conferences::Presentation'
              INNER JOIN spina_page_parts ON conference_page_id = page_id
      )
      INSERT INTO spina_conferences_parts (title, name, partable_id, partable_type, pageable_id, pageable_type)
        SELECT title, name, page_partable_id, page_partable_type, pageable_id, pageable_type FROM parts
    SQL
    delete <<-SQL, 'Delete page parts'
      WITH parts AS (
        SELECT spina_page_parts.id AS id
          FROM spina_conferences_conferences
            LEFT JOIN spina_conferences_conference_page_parts
              ON conference_page_partable_id = spina_conferences_conferences.id
              AND conference_page_partable_type = 'Spina::Conferences::Conference'
            LEFT JOIN spina_page_parts ON conference_page_id = page_id
        UNION
          SELECT spina_page_parts.id
            FROM spina_conferences_presentations
              LEFT JOIN spina_conferences_conference_page_parts
                ON conference_page_partable_id = spina_conferences_presentations.id
                AND conference_page_partable_type = 'Spina::Conferences::Presentation'
              LEFT JOIN spina_page_parts ON conference_page_id = page_id
      )
      DELETE FROM spina_page_parts USING parts WHERE spina_page_parts.id = parts.id
    SQL
    delete <<-SQL, 'Delete pages'
      DELETE FROM spina_pages USING spina_conferences_conference_page_parts WHERE conference_page_id = spina_pages.id
    SQL
    delete <<-SQL, 'Delete conference page parts'
      DELETE FROM spina_conferences_conference_page_parts
        USING spina_conferences_conferences, spina_conferences_presentations
          WHERE (
            conference_page_partable_id = spina_conferences_conferences.id
              AND conference_page_partable_type = 'Spina::Conferences::Conference'
          )
            OR (
              conference_page_partable_id = spina_conferences_presentations.id
                AND conference_page_partable_type = 'Spina::Conferences::Presentation'
            )
    SQL
    delete <<-SQL, 'Delete conferences page'
      DELETE FROM spina_pages WHERE name = 'conferences'
    SQL
    delete <<-SQL, 'Delete conference pages resource'
      DELETE FROM spina_resources WHERE name = 'conference_pages'
    SQL
    remove_column :spina_pages, :type
  end

  def down
    add_column :spina_pages, :type, :string
    insert <<-SQL, 'Insert resource if missing'
      INSERT INTO spina_resources (name, label, created_at, updated_at)
        SELECT 'conference_pages', 'Conference pages', current_timestamp, current_timestamp
          WHERE NOT EXISTS (SELECT name FROM spina_resources WHERE name = 'conference_pages')
    SQL
    locale = ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)
    insert <<-SQL, 'Insert root page if missing', nil, nil, nil, [locale]
      WITH pages AS (
        INSERT INTO spina_pages (name, view_template, deletable, created_at, updated_at)
          SELECT 'conferences', 'conferences', false, current_timestamp, current_timestamp
            WHERE NOT EXISTS (SELECT name FROM spina_pages WHERE name = 'conferences')
          RETURNING id
      )
      INSERT INTO spina_page_translations (title, spina_page_id, locale, created_at, updated_at)
        SELECT 'Conferences', pages.id, $1, current_timestamp, current_timestamp FROM pages
    SQL
    insert <<-SQL, 'Insert conference pages for conferences', nil, nil, nil, [locale]
      WITH
        resources AS (SELECT id FROM spina_resources WHERE name = 'conference_pages' LIMIT 1),
        conferences_pages AS (SELECT id FROM spina_pages WHERE view_template = 'conferences' LIMIT 1),
        conference_pages_to_insert AS (
          SELECT
            concat_ws(' ', name, date_part('year', lower(dates))) AS title,
            false AS deletable,
            resources.id AS resource_id,
            conferences_pages.id AS ancestry,
            'conference' AS view_template,
            spina_conferences_conferences.id AS conference_id,
            'Spina::Conferences::Conference' AS type
            FROM spina_conferences_conferences
              INNER JOIN spina_conferences_institutions ON institution_id = spina_conferences_institutions.id
              CROSS JOIN resources
              CROSS JOIN conferences_pages
            ORDER BY type, spina_conferences_conferences.id
        ), conference_pages AS (
          INSERT INTO spina_pages (deletable, resource_id, ancestry, view_template, type, created_at, updated_at)
            SELECT
              deletable, resource_id, ancestry, view_template, 'Spina::Conferences::ConferencePage', current_timestamp, current_timestamp
              FROM conference_pages_to_insert
            RETURNING id AS page_id
        ), conference_page_translations AS (
          INSERT INTO spina_page_translations (spina_page_id, locale, title, created_at, updated_at)
            SELECT page_id, $1, title, current_timestamp, current_timestamp
              FROM (
                SELECT title, row_number() OVER (ORDER BY type, conference_id) AS index FROM conference_pages_to_insert
              ) AS pages_to_insert_with_indices
                INNER JOIN (
                  SELECT page_id, row_number() OVER (ORDER BY page_id) AS index FROM conference_pages
                ) AS pages_with_indices USING (index)
        )
      INSERT INTO spina_conferences_conference_page_parts
        (conference_page_id, conference_page_partable_id, conference_page_partable_type, created_at, updated_at) 
        SELECT page_id, conference_id, type, current_timestamp, current_timestamp
          FROM (
            SELECT conference_id, type, row_number() OVER (ORDER BY type, conference_id) AS index FROM conference_pages_to_insert
          ) AS pages_to_insert_with_indices
            INNER JOIN (
              SELECT page_id, row_number() OVER (ORDER BY page_id) AS index FROM conference_pages
            ) AS pages_with_indices USING (index)
    SQL
    insert <<-SQL, 'Insert conference pages for presentations', nil, nil, nil, [locale]
      WITH
        resources AS (SELECT id FROM spina_resources WHERE name = 'conference_pages' LIMIT 1),
        conference_pages_to_insert AS (
          SELECT
            title,
            false AS deletable,
            resources.id AS resource_id,
            spina_conferences_conference_page_parts.conference_page_id AS ancestry,
            'presentation' AS view_template,
            spina_conferences_presentations.id AS presentation_id,
            'Spina::Conferences::Presentation' AS type
            FROM spina_conferences_presentations
                INNER JOIN spina_conferences_room_uses ON room_use_id = spina_conferences_room_uses.id
                INNER JOIN spina_conferences_presentation_types ON presentation_type_id = spina_conferences_presentation_types.id
                INNER JOIN spina_conferences_conference_page_parts
                  ON conference_page_partable_id = conference_id AND conference_page_partable_type = 'Spina::Conferences::Conference'
                CROSS JOIN resources
            ORDER BY type, presentation_id
        ), conference_pages AS (
          INSERT INTO spina_pages (deletable, resource_id, ancestry, view_template, type, created_at, updated_at)
            SELECT
              deletable, resource_id, ancestry, view_template, 'Spina::Conferences::ConferencePage', current_timestamp, current_timestamp
              FROM conference_pages_to_insert
            RETURNING id AS page_id
        ), conference_page_translations AS (
          INSERT INTO spina_page_translations (spina_page_id, locale, title, created_at, updated_at)
            SELECT page_id, $1, title, current_timestamp, current_timestamp
              FROM (
                SELECT title, row_number() OVER (ORDER BY type, presentation_id) AS index FROM conference_pages_to_insert
              ) AS conference_pages_with_indices
                INNER JOIN (
                  SELECT page_id, row_number() OVER (ORDER BY page_id) AS index FROM conference_pages
                ) AS pages_with_indices USING (index)
        )
      INSERT INTO spina_conferences_conference_page_parts
        (conference_page_id, conference_page_partable_id, conference_page_partable_type, created_at, updated_at) 
        SELECT page_id, presentation_id, type, current_timestamp, current_timestamp
          FROM (
            SELECT presentation_id, type, row_number() OVER (ORDER BY type, presentation_id) AS index FROM conference_pages_to_insert
          ) AS conference_pages_with_indices
            INNER JOIN (
              SELECT page_id, row_number() OVER (ORDER BY page_id) AS index FROM conference_pages
            ) AS pages_with_indices USING (index)
    SQL
    insert <<-SQL, 'Insert page parts'
      INSERT INTO spina_page_parts (title, name, page_id, page_partable_id, page_partable_type, created_at, updated_at)
        SELECT
          spina_conferences_parts.title, spina_conferences_parts.name, spina_pages.id, partable_id, partable_type, current_timestamp,
          current_timestamp
          FROM spina_conferences_parts
            LEFT JOIN spina_conferences_conferences
              ON pageable_id = spina_conferences_conferences.id AND pageable_type = 'Spina::Conferences::Conference'
            LEFT JOIN spina_conferences_presentations
              ON pageable_id = spina_conferences_presentations.id AND pageable_type = 'Spina::Conferences::Presentation'
            INNER JOIN spina_conferences_conference_page_parts
              ON pageable_id = conference_page_partable_id AND pageable_type = conference_page_partable_type
            INNER JOIN spina_pages ON conference_page_id = spina_pages.id
    SQL
    delete <<-SQL, 'Delete conference parts'
      DELETE FROM spina_conferences_parts USING spina_page_parts WHERE page_partable_id = partable_id AND page_partable_type = partable_type
    SQL
  end
end
