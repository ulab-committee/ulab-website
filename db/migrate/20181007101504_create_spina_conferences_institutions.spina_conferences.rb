# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141231)

class CreateSpinaConferencesInstitutions < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_conferences_institutions do |t|
      t.string :name
      t.string :city

      t.timestamps null: false
    end
  end
end
