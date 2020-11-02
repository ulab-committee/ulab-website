# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420121321)

class RemoveNameFromSpinaConferencesPresentationTypes < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    remove_column :spina_conferences_presentation_types, :name, :string
  end
end
