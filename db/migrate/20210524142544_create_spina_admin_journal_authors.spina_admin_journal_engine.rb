# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201216211224)

class CreateSpinaAdminJournalAuthors < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_authors, &:timestamps
  end
end
