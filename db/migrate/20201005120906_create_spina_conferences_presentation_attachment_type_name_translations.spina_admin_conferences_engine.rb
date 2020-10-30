# frozen_string_literal: true
# This migration comes from spina_admin_conferences_engine (originally 20200420105144)

class CreateSpinaConferencesPresentationAttachmentTypeNameTranslations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_conferences_presentation_attachment_type_translations do |t|
      # Translated attribute(s)
      t.string :name

      t.string :locale, null: false
      t.references :spina_conferences_presentation_attachment_type,
                   null: false, foreign_key: { on_delete: :cascade }, index: false

      t.timestamps null: false
    end

    add_index :spina_conferences_presentation_attachment_type_translations, :locale, name: :index_f3417b08c78b5a87825d3f14b49fb06e76b8bed4
    add_index :spina_conferences_presentation_attachment_type_translations, %i[spina_conferences_presentation_attachment_type_id locale],
              name: :index_1b650dff92fcf8462275bfd83c507ea5c40b3ebb, unique: true
  end
end
