# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20210521121318)

class AddStatusToSpinaAdminJournalArticles < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_admin_journal_articles, :status, :integer, null: false, default: 0
  end
end
