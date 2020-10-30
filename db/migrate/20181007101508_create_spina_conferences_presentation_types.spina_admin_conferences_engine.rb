# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141236)

class CreateSpinaConferencesPresentationTypes < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_conferences_presentation_types do |t|
      t.string :name
      t.interval :duration
      t.belongs_to :conference, foreign_key: { to_table: :spina_conferences_conferences }

      t.timestamps null: false
    end
  end
end
