# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20201007125625)

class AddTimestampsToSpinaConferencesParts < ActiveRecord::Migration[6.0]
  def change
    default = Time.now
    add_timestamps :spina_conferences_parts, default: default
    change_column_default :spina_conferences_parts, :created_at, from: default, to: nil
    change_column_default :spina_conferences_parts, :updated_at, from: default, to: nil
  end
end
