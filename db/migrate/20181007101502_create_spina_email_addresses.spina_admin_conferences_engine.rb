# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141229)

class CreateSpinaEmailAddresses < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_email_addresses do |t|
      t.string :content

      t.timestamps null: false
    end
  end
end
