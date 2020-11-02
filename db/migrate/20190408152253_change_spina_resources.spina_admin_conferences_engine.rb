# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20190408131354)

class ChangeSpinaResources < ActiveRecord::Migration[6.0] #:nodoc:
  def up
    insert <<-SQL, 'Insert conference pages resource if missing'
      INSERT INTO spina_resources (name, label, created_at, updated_at)
        SELECT 'conference_pages', 'Conference pages', current_timestamp, current_timestamp
          WHERE NOT EXISTS (SELECT name FROM spina_resources WHERE name = 'conference_pages')
    SQL
    update <<-SQL, 'Update conference conference pages'
      WITH resources AS (SELECT id FROM spina_resources WHERE name = 'conference_pages' LIMIT 1)
      UPDATE spina_pages SET ancestry = null, resource_id = resources.id
        FROM spina_conferences_conference_page_parts, resources
        WHERE conference_page_id = spina_pages.id AND conference_page_partable_type = 'Spina::Conferences::Conference'
    SQL
    update <<-SQL, 'Update presentation conference pages'
      WITH resources AS (SELECT id FROM spina_resources WHERE name = 'conference_pages' LIMIT 1)
      UPDATE spina_pages SET resource_id = resources.id
        FROM spina_conferences_conference_page_parts, resources
        WHERE conference_page_id = spina_pages.id AND conference_page_partable_type = 'Spina::Conferences::Presentation'
    SQL
    delete <<-SQL, 'Delete resources'
      DELETE FROM spina_resources WHERE name IN ('conferences', 'presentations')
    SQL
  end

  def down
    insert <<-SQL, 'Insert conferences resource if missing'
      INSERT INTO spina_resources (name, label, view_template, created_at, updated_at)
        SELECT 'conferences', 'Conferences', 'conference', current_timestamp, current_timestamp
          WHERE NOT EXISTS (SELECT name FROM spina_resources WHERE name = 'conferences')
    SQL
    update <<-SQL, 'Update conference conference pages'
      WITH
        conferences_resources AS (SELECT id FROM spina_resources WHERE name = 'conferences' LIMIT 1),
        conferences_pages AS (SELECT id FROM spina_pages WHERE view_template = 'conference' LIMIT 1)
      UPDATE spina_pages SET ancestry = conferences_pages.id, resource_id = conferences_resources.id
        FROM spina_conferences_conference_page_parts, conferences_resources, conferences_pages
        WHERE conference_page_id = spina_pages.id AND conference_page_partable_type = 'Spina::Conferences::Conference'
    SQL
    insert <<-SQL, 'Insert presentations resource if missing'
      INSERT INTO spina_resources (name, label, view_template, created_at, updated_at)
        SELECT 'presentations', 'Presentations', 'presentation', current_timestamp, current_timestamp
          WHERE NOT EXISTS (SELECT name FROM spina_resources WHERE name = 'presentations')
    SQL
    update <<-SQL, 'Update presentation conference pages'
      WITH presentations_resources AS (SELECT id FROM spina_resources WHERE name = 'presentations' LIMIT 1)
      UPDATE spina_pages SET resource_id = presentations_resources.id
        FROM spina_conferences_conference_page_parts, presentations_resources
        WHERE conference_page_id = spina_pages.id AND conference_page_partable_type = 'Spina::Conferences::Presentation'
    SQL
    delete <<-SQL, 'Delete resources'
      DELETE FROM spina_resources WHERE name = 'conference_pages'
    SQL
  end
end
