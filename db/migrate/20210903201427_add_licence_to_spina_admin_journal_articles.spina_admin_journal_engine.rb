# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20210618094533)

class AddLicenceToSpinaAdminJournalArticles < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_reference :spina_admin_journal_articles, :licence, null: true,
                                                           foreign_key: { to_table: :spina_admin_journal_licences }
  end
end
