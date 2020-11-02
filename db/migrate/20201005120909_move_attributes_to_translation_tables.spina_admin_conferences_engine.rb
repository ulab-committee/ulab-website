# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420110407)

class MoveAttributesToTranslationTables < ActiveRecord::Migration[6.0] # :nodoc:
  def up
    insert_dietary_requirement_translations
    insert_institution_translations
    insert_presentation_translations
    insert_presentation_attachment_type_translations
    insert_presentation_type_translations
    insert_room_translations
  end

  def down
    update_dietary_requirements
    update_institutions
    update_presentations
    update_presentation_attachment_types
    update_presentation_types
    update_rooms
    add_null_constraints
  end

  private

  def add_null_constraints
    change_column_null :spina_conferences_dietary_requirements, :name, false
    change_column_null :spina_conferences_institutions, :name, false
    change_column_null :spina_conferences_institutions, :city, false
    change_column_null :spina_conferences_presentation_types, :name, false
    change_column_null :spina_conferences_presentation_attachment_types, :name, false
    change_column_null :spina_conferences_presentations, :title, false
    change_column_null :spina_conferences_presentations, :abstract, false
    change_column_null :spina_conferences_rooms, :number, false
    change_column_null :spina_conferences_rooms, :building, false
  end

  def update_dietary_requirements
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    update <<-SQL.squish, 'Add dietary requirement attributes', binds
      UPDATE spina_conferences_dietary_requirements SET name = translations.name
        FROM spina_conferences_dietary_requirement_translations AS translations
          WHERE spina_conferences_dietary_requirement_id = spina_conferences_dietary_requirements.id AND locale = $1
    SQL
    delete <<-SQL.squish, 'Delete translations'
      DELETE FROM spina_conferences_dietary_requirement_translations
    SQL
  end

  def update_institutions
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    update <<-SQL.squish, 'Add institution attributes', binds
      UPDATE spina_conferences_institutions SET (name, city) = (translations.name, translations.city)
        FROM spina_conferences_institution_translations AS translations
          WHERE translations.spina_conferences_institution_id = spina_conferences_institutions.id AND locale = $1
    SQL
    delete <<-SQL.squish, 'Delete translations'
      DELETE FROM spina_conferences_institution_translations
    SQL
  end

  def update_presentations
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    update <<-SQL.squish, 'Add presentation attributes', binds
      UPDATE spina_conferences_presentations SET (title, abstract) = (translations.title, translations.abstract)
        FROM spina_conferences_presentation_translations AS translations
          WHERE spina_conferences_presentation_id = spina_conferences_presentations.id AND locale = $1
    SQL
    delete <<-SQL.squish, 'Delete translations'
      DELETE FROM spina_conferences_presentation_translations
    SQL
  end

  def update_presentation_attachment_types
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    update <<-SQL.squish, 'Add presentation attachment type attributes', binds
      UPDATE spina_conferences_presentation_attachment_types SET name = translations.name
        FROM spina_conferences_presentation_attachment_type_translations AS translations
          WHERE spina_conferences_presentation_attachment_type_id = spina_conferences_presentation_attachment_types.id AND locale = $1
    SQL
    delete <<-SQL.squish, 'Delete translations'
      DELETE FROM spina_conferences_presentation_attachment_type_translations
    SQL
  end

  def update_presentation_types
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    update <<-SQL.squish, 'Add presentation type attributes', binds
      UPDATE spina_conferences_presentation_types SET name = translations.name
        FROM spina_conferences_presentation_type_translations AS translations
          WHERE spina_conferences_presentation_type_id = spina_conferences_presentation_types.id AND locale = $1
    SQL
    delete <<-SQL.squish, 'Delete translations'
      DELETE FROM spina_conferences_presentation_type_translations
    SQL
  end

  def update_rooms
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    update <<-SQL.squish, 'Add room attributes', binds
      UPDATE spina_conferences_rooms SET (building, number) = (translations.building, translations.number)
        FROM spina_conferences_room_translations AS translations
          WHERE spina_conferences_room_id = spina_conferences_rooms.id AND locale = $1
    SQL
    delete <<-SQL.squish, 'Delete translations'
      DELETE FROM spina_conferences_room_translations
    SQL
  end

  def insert_dietary_requirement_translations
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Insert dietary requirement translations', nil, nil, nil, binds
      INSERT INTO spina_conferences_dietary_requirement_translations
        (name, locale, created_at, updated_at, spina_conferences_dietary_requirement_id)
        SELECT name, $1, created_at, updated_at, id FROM spina_conferences_dietary_requirements
    SQL
  end

  def insert_institution_translations
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Insert institution translations', nil, nil, nil, binds
      INSERT INTO spina_conferences_institution_translations
        (name, city, locale, created_at, updated_at, spina_conferences_institution_id)
        SELECT name, city, $1, created_at, updated_at, id FROM spina_conferences_institutions
    SQL
  end

  def insert_presentation_translations
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Insert presentation translations', nil, nil, nil, binds
      INSERT INTO spina_conferences_presentation_translations
        (title, abstract, locale, created_at, updated_at, spina_conferences_presentation_id)
        SELECT title, abstract, $1, created_at, updated_at, id FROM spina_conferences_presentations
    SQL
  end

  def insert_presentation_attachment_type_translations
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Insert presentation attachment type translations', nil, nil, nil, binds
      INSERT INTO spina_conferences_presentation_attachment_type_translations
        (name, locale, created_at, updated_at, spina_conferences_presentation_attachment_type_id)
        SELECT name, $1, created_at, updated_at, id FROM spina_conferences_presentation_attachment_types
    SQL
  end

  def insert_presentation_type_translations
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Insert presentation type translations', nil, nil, nil, binds
      INSERT INTO spina_conferences_presentation_type_translations
        (name, locale, created_at, updated_at, spina_conferences_presentation_type_id)
        SELECT name, $1, created_at, updated_at, id FROM spina_conferences_presentation_types
    SQL
  end

  def insert_room_translations
    binds = [ActiveRecord::Relation::QueryAttribute.new('locale', I18n.default_locale, ActiveRecord::Type::String.new)]
    insert <<-SQL.squish, 'Insert room translations', nil, nil, nil, binds
      INSERT INTO spina_conferences_room_translations (building, number, locale, created_at, updated_at, spina_conferences_room_id)
        SELECT building, number, $1, created_at, updated_at, id FROM spina_conferences_rooms
    SQL
  end
end
