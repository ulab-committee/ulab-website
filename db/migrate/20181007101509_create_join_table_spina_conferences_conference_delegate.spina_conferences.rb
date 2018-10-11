# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141238)

class CreateJoinTableSpinaConferencesConferenceDelegate < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_join_table :spina_conferences_conferences, :spina_conferences_delegates
  end
end
