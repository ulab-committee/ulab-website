# frozen_string_literal: true
# This migration comes from spina_admin_journal_engine (originally 20201216230816)

class CreateSpinaAdminJournalAuthorships < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_authorships do |t|
      t.references :article, null: false, foreign_key: { to_table: :spina_admin_journal_articles }
      t.references :affiliation, null: false, foreign_key: { to_table: :spina_admin_journal_affiliations }
      t.index %i[article_id affiliation_id], unique: true, name: :index_authorships_on_article_id_and_affiliation_id
      t.index %i[affiliation_id article_id], unique: true, name: :index_authorships_on_affiliation_id_and_article_id

      t.timestamps
    end
  end
end
