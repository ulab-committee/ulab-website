# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420120759)

class RemoveNameAndCityFromSpinaConferencesInstitutions < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    remove_column :spina_conferences_institutions, :name, :string
    remove_column :spina_conferences_institutions, :city, :string
  end
end
