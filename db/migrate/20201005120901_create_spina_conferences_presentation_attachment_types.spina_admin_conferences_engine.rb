# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200126034441)

class CreateSpinaConferencesPresentationAttachmentTypes < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_presentation_attachment_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
