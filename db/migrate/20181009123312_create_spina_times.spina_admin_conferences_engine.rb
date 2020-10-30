# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20181009122503)

class CreateSpinaTimes < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_times do |t|
      t.datetime :content

      t.timestamps null: false
    end
  end
end
