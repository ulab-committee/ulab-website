# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200911161651)

class UpdateSpinaParts < ActiveRecord::Migration[6.0] # :nodoc:
  def up
    update <<-SQL.squish, 'Add namespacing to class names for page parts'
      UPDATE spina_page_parts SET page_partable_type = replace(page_partable_type, 'Spina::Conferences', 'Spina::Admin::Conferences')
        WHERE starts_with(page_partable_type, 'Spina::Conferences')
    SQL
    update <<-SQL.squish, 'Add namespacing to class names for structure parts'
      UPDATE spina_structure_parts
        SET structure_partable_type = replace(structure_partable_type, 'Spina::Conferences', 'Spina::Admin::Conferences')
        WHERE starts_with(structure_partable_type, 'Spina::Conferences')
    SQL
    update <<-SQL.squish, 'Add namespacing to class names for layout parts'
      UPDATE spina_layout_parts
        SET layout_partable_type = replace(layout_partable_type, 'Spina::Conferences', 'Spina::Admin::Conferences')
        WHERE starts_with(layout_partable_type, 'Spina::Conferences')
    SQL
  end

  def down
    update <<-SQL.squish, 'Remove namespacing from class names for page parts'
      UPDATE spina_page_parts SET page_partable_type = replace(page_partable_type, 'Spina::Admin::Conferences', 'Spina::Conferences')
        WHERE starts_with(page_partable_type, 'Spina::Admin::Conferences')
    SQL
    update <<-SQL.squish, 'Remove namespacing from class names for structure parts'
      UPDATE spina_structure_parts
        SET structure_partable_type = replace(structure_partable_type, 'Spina::Admin::Conferences', 'Spina::Conferences')
        WHERE starts_with(structure_partable_type, 'Spina::Admin::Conferences')
    SQL
    update <<-SQL.squish, 'Remove namespacing from class names for layout parts'
      UPDATE spina_layout_parts
        SET layout_partable_type = replace(layout_partable_type, 'Spina::Admin::Conferences', 'Spina::Conferences')
        WHERE starts_with(layout_partable_type, 'Spina::Admin::Conferences')
    SQL
  end
end
