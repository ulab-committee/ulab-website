# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200502183410)

class RemoveInstitutionFromSpinaConferencesConferences < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    remove_reference :spina_conferences_conferences, :institution,
                     foreign_key: { to_table: :spina_conferences_institutions }
  end
end
