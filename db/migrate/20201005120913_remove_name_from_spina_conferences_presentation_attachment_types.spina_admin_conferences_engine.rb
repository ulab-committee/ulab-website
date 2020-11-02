# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420121310)

class RemoveNameFromSpinaConferencesPresentationAttachmentTypes < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    remove_column :spina_conferences_presentation_attachment_types, :name, :string
  end
end
