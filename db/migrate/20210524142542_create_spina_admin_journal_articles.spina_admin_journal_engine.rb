# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201216161122)

class CreateSpinaAdminJournalArticles < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_articles do |t|
      t.integer :number, null: false, default: 0
      t.string :title, null: false
      t.string :url, null: false, default: ''
      t.string :doi, null: false, default: ''
      t.references :issue, null: false, foreign_key: { to_table: :spina_admin_journal_issues }

      t.timestamps
    end
  end
end
