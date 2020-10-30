# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200126213718)

class CreateSpinaConferencesPresentationAttachments < ActiveRecord::Migration[6.0] # :nodoc:
  def change # rubocop:disable Metrics/MethodLength
    create_table :spina_conferences_presentation_attachments do |t|
      t.references :presentation,
                   null: false, foreign_key: { to_table: :spina_conferences_presentations, on_delete: :cascade },
                   index: { name: 'index_conferences_presentation_attachments_on_presentation_id' }
      t.references :attachment_type,
                   null: false,
                   foreign_key: { to_table: :spina_conferences_presentation_attachment_types, on_delete: :cascade },
                   index: { name: 'index_conferences_presentation_attachments_on_type_id' }
      t.references :attachment, foreign_key: { to_table: :spina_attachments, on_delete: :nullify },
                                index: { name: 'index_conferences_presentation_attachments_on_attachment_id' }

      t.timestamps null: false
    end
  end
end
