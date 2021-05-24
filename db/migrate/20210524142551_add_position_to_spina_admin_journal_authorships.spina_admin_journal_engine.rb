# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20210512122931)

class AddPositionToSpinaAdminJournalAuthorships < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_admin_journal_authorships, :position, :integer, null: false, default: 0
  end
end
