# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201216153822)

class CreateSpinaAdminJournalVolumes < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_volumes do |t|
      t.integer :number, null: false
      t.string :title, null: false, default: ''
      t.references :journal, null: false, foreign_key: { to_table: :spina_admin_journal_journals }

      t.timestamps
    end
  end
end
