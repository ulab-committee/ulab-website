# frozen_string_literal: true
# This migration comes from spina_admin_conferences (originally 20210315164409)

class AddJsonAttributesToSpinaConferencesPresentations < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_conferences_presentations, :json_attributes, :jsonb
  end
end
