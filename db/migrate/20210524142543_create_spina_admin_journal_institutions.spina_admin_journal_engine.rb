# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201216205633)

class CreateSpinaAdminJournalInstitutions < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_institutions do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
