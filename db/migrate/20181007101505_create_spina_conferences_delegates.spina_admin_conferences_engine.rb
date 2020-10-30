# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141232)

class CreateSpinaConferencesDelegates < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_conferences_delegates do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :url
      t.belongs_to :institution,
                   foreign_key: { to_table: :spina_conferences_institutions }

      t.timestamps null: false
    end
  end
end
