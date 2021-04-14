# frozen_string_literal: true
# This migration comes from spina_admin_conferences (originally 20210315164410)

class AddJsonAttributesToSpinaConferencesConferences < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_column :spina_conferences_conferences, :json_attributes, :jsonb
  end
end
