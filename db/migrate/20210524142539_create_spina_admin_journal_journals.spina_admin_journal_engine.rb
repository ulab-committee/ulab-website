# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201216152147)

class CreateSpinaAdminJournalJournals < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_journals do |t|
      t.string :name, null: false, default: 'Unnamed Journal'
      t.integer :singleton_guard, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
