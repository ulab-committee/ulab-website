# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141234)

class CreateSpinaConferencesDietaryRequirements < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_conferences_dietary_requirements do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
