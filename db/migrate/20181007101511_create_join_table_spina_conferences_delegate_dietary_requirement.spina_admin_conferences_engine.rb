# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141240)

class CreateJoinTableSpinaConferencesDelegateDietaryRequirement < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_join_table :spina_conferences_delegates,
                      :spina_conferences_dietary_requirements
  end
end
