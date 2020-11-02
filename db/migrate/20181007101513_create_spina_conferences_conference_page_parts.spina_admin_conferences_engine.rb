# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20180907141243)

class CreateSpinaConferencesConferencePageParts < ActiveRecord::Migration[5.2] #:nodoc:
  def change
    create_table :spina_conferences_conference_page_parts do |t|
      t.belongs_to(
        :conference_page,
        foreign_key: { to_table: :spina_pages, on_delete: :cascade },
        index: {
          name:
            'index_spina_conferences_parts_on_page_id'
        }
      )
      t.belongs_to(
        :conference_page_partable,
        polymorphic: true,
        index: {
          name: 'index_spina_conferences_parts_on_partable_type_and_partable_id'
        }
      )

      t.timestamps
    end
  end
end
