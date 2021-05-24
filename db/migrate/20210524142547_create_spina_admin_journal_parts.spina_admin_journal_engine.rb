# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201231165231)

class CreateSpinaAdminJournalParts < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_parts do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.string :title
      t.string :name
      t.references :partable, polymorphic: true, index: false
      t.references :pageable, polymorphic: true, index: false
    end
  end
end
