# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20210424123521)

class AddJsonAttributesToSpinaAdminJournalIssues < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_admin_journal_issues, :json_attributes, :jsonb
  end
end
