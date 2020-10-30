# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200911161632)

class UpdateSpinaConferencesParts < ActiveRecord::Migration[6.0] # :nodoc:
  def up
    update <<-SQL.squish, 'Add namespacing to class names'
      UPDATE spina_conferences_parts
        SET
          partable_type = replace(partable_type, 'Spina::Conferences', 'Spina::Admin::Conferences'),
          pageable_type = replace(pageable_type, 'Spina::Conferences', 'Spina::Admin::Conferences')
        WHERE starts_with(partable_type, 'Spina::Conferences') OR starts_with(pageable_type, 'Spina::Conferences')
    SQL
  end

  def down
    update <<-SQL.squish, 'Remove namespacing from class names'
      UPDATE spina_conferences_parts
        SET
          partable_type = replace(partable_type, 'Spina::Admin::Conferences', 'Spina::Conferences'),
          pageable_type = replace(pageable_type, 'Spina::Admin::Conferences', 'Spina::Conferences')
        WHERE starts_with(partable_type, 'Spina::Admin::Conferences') OR starts_with(pageable_type, 'Spina::Admin::Conferences')
    SQL
  end
end
