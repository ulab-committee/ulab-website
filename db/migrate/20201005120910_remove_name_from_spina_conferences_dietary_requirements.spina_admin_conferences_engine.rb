# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420120706)

class RemoveNameFromSpinaConferencesDietaryRequirements < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    remove_column :spina_conferences_dietary_requirements, :name, :string
  end
end
