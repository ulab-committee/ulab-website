# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20210424123555)

class AddJsonAttributesToSpinaAdminJournalArticles < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_admin_journal_articles, :json_attributes, :jsonb
  end
end
