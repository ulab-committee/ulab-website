# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201216221146)

class CreateSpinaAdminJournalAffiliations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_affiliations do |t|
      t.string :first_name, null: false
      t.string :surname, null: false
      t.integer :status, null: false, default: 0
      t.references :institution, null: false, foreign_key: { to_table: :spina_admin_journal_institutions }
      t.references :author, null: false, foreign_key: { to_table: :spina_admin_journal_authors }

      t.timestamps
    end
  end
end
