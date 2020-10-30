# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200911161726)

class MovePresentationParts < ActiveRecord::Migration[6.0] # :nodoc:
  def up
    create_presentation_attachment_types
    create_presentation_attachments
    delete_presentation_parts
  end

  def down
    create_parts
    delete_presentation_attachments
    delete_presentation_attachment_type_translations
    delete_presentation_attachment_types
  end

  private

  def create_presentation_attachment_types
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Create presentation attachment types', nil, nil, nil, binds
      WITH attachment_type_names AS (
        SELECT DISTINCT ON (title) title, id
          FROM spina_conferences_parts
          WHERE pageable_type = 'Spina::Admin::Conferences::Presentation' AND partable_type = 'Spina::Attachment'
          ORDER BY title
      ), attachment_types AS (
        INSERT INTO spina_conferences_presentation_attachment_types (created_at, updated_at)
          SELECT current_timestamp, current_timestamp FROM attachment_type_names
        RETURNING id
      )
      INSERT INTO spina_conferences_presentation_attachment_type_translations
        (name, locale, spina_conferences_presentation_attachment_type_id, created_at, updated_at)
        SELECT title, $1, id, current_timestamp, current_timestamp
          FROM (
            SELECT title, row_number() over (ORDER BY id) AS index FROM attachment_type_names
          ) AS attachment_type_names_with_indices
            INNER JOIN (
              SELECT id, row_number() over (ORDER BY id) AS index FROM attachment_types
            ) AS attachment_types_with_indices USING (index)
    SQL
  end

  def create_presentation_attachments
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Create presentation attachments', nil, nil, nil, binds
      INSERT INTO spina_conferences_presentation_attachments (presentation_id, attachment_type_id, attachment_id, created_at, updated_at)
        SELECT pageable_id, spina_conferences_presentation_attachment_type_id, partable_id, current_timestamp, current_timestamp
          FROM spina_conferences_parts
            INNER JOIN spina_conferences_presentation_attachment_type_translations
              ON spina_conferences_parts.name = replace(lower(spina_conferences_presentation_attachment_type_translations.name),'\W', '_')
                AND locale = $1
          WHERE pageable_type = 'Spina::Admin::Conferences::Presentation'
            AND partable_type = 'Spina::Attachment'
    SQL
  end

  def delete_presentation_parts
    delete <<-SQL.squish, 'Delete presentation parts'
      DELETE FROM spina_conferences_parts
        WHERE pageable_type = 'Spina::Admin::Conferences::Presentation' AND partable_type = 'Spina::Attachment'
    SQL
  end

  def create_parts
    insert <<-SQL.squish, 'Create parts'
      INSERT INTO spina_conferences_parts (title, name, partable_type, partable_id, pageable_type, pageable_id)
        SELECT name, replace(lower(name),'\W', '_'), 'Spina::Admin::Conferences::Presentation', presentation_id, 'Spina::Attachment',
          attachment_id
          FROM spina_conferences_presentation_attachments
            INNER JOIN spina_conferences_presentation_attachment_type_translations
              ON attachment_type_id = spina_conferences_presentation_attachment_type_id
    SQL
  end

  def delete_presentation_attachments
    delete <<-SQL.squish, 'Delete presentation attachments'
      DELETE FROM spina_conferences_presentation_attachments
        USING spina_conferences_parts
        WHERE title = name AND pageable_id = presentation_id
    SQL
  end

  def delete_presentation_attachment_type_translations
    delete <<-SQL.squish, 'Delete presentation attachment type translations'
      DELETE FROM spina_conferences_presentation_attachment_type_translations
        USING spina_conferences_presentation_attachments, spina_conferences_parts
        WHERE attachment_type_id != spina_conferences_presentation_attachment_type_id
          AND spina_conferences_presentation_attachment_type_translations.name = title
    SQL
  end

  def delete_presentation_attachment_types
    delete <<-SQL.squish, 'Delete presentation attachment types'
      DELETE FROM spina_conferences_presentation_attachment_types
        USING spina_conferences_presentation_attachments, spina_conferences_presentation_attachment_type_translations
        WHERE attachment_type_id != spina_conferences_presentation_attachments.id
          AND spina_conferences_presentation_attachment_type_id != spina_conferences_presentation_attachments.id
    SQL
  end
end
