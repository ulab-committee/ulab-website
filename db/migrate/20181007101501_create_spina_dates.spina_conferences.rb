# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141228)

class CreateSpinaDates < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_dates do |t|
      t.date :content

      t.timestamps null: false
    end
  end
end
