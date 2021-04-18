# frozen_string_literal: true
# This migration comes from spina_admin_conferences (originally 20210417102514)

class MoveTextsToActionTextRichTexts < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    create_mobility_tables

    Spina.config.locales.each do |locale|
      I18n.with_locale(locale) do
        move_presentation_abstracts
        move_event_descriptions
      end
    end

    remove_column :spina_conferences_presentation_translations, :abstract, :text
    remove_column :spina_conferences_event_translations, :description, :text
  end

  private

  def create_mobility_tables
    create_table :mobility_text_translations do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.string :record
    end
    create_table :mobility_string_translations do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.string :record
    end
  end

  def move_presentation_abstracts
    reversible do |dir|
      Spina::Admin::Conferences::Presentation.in_batches.each_record do |presentation|
        dir.up { presentation.update(abstract: presentation.presentation_translation.abstract) }
        dir.down do
          break if presentation.abstract.blank?

          presentation.presentation_translation.update(abstract: presentation.abstract.read_attribute_before_type_cast('body'))
          presentation.abstract.destroy
        end
      end
    end
  end

  def move_event_descriptions
    reversible do |dir|
      Spina::Admin::Conferences::Event.in_batches.each_record do |event|
        dir.up { event.update(description: event.event_translation.description) }
        dir.down do
          break if event.description.blank?

          event.event_translation.update(description: event.description.read_attribute_before_type_cast('body'))
          event.description.destroy
        end
      end
    end
  end
end

module Spina
  module Admin
    module Conferences
      class PresentationTranslation < ApplicationRecord
        belongs_to :presentation, foreign_key: 'spina_conferences_presentation_id'
      end

      class EventTranslation < ApplicationRecord
        belongs_to :event, foreign_key: 'spina_conferences_event_id'
      end

      class Presentation < ApplicationRecord
        has_one :presentation_translation, -> { where locale: I18n.locale }, foreign_key: 'spina_conferences_presentation_id'

        translates :abstract, backend: :action_text
      end

      class Event < ApplicationRecord
        has_one :event_translation, -> { where locale: I18n.locale }, foreign_key: 'spina_conferences_event_id'

        translates :description, backend: :action_text
      end
    end
  end
end
