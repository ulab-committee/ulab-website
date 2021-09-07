# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20210626153728)

class CreateSpinaPartsAdminJournalPageRanges < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    create_table :spina_parts_admin_journal_page_ranges, &:timestamps
  end
end
