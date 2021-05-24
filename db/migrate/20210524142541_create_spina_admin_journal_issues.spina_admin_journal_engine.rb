# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201216155113)

class CreateSpinaAdminJournalIssues < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_issues do |t|
      t.integer :number, null: false
      t.string :title, null: false, default: ''
      t.date :date, null: false
      t.references :volume, null: false, foreign_key: { to_table: :spina_admin_journal_volumes }

      t.timestamps
    end
  end
end
