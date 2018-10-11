# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141239)

class CreateJoinTableSpinaConferencesDelegatePresentation < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_join_table :spina_conferences_delegates, :spina_conferences_presentations
  end
end
