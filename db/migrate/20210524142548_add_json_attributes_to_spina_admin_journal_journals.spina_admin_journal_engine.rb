# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20210424123450)

class AddJsonAttributesToSpinaAdminJournalJournals < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_admin_journal_journals, :json_attributes, :jsonb
  end
end
