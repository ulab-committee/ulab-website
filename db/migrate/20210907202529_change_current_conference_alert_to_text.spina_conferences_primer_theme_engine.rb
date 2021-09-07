# frozen_string_literal: true
# This migration comes from spina_conferences_primer_theme_engine (originally 20210206170704)

class ChangeCurrentConferenceAlertToText < ActiveRecord::Migration[6.0]
  def up
    Spina::LayoutPart.where(name: 'current_conference_alert', layout_partable_type: 'Spina::Line').each do |layout_part|
      if layout_part.partable.present?
        Spina::Text.create(content: layout_part.partable.content).then do |text|
          layout_part.partable.destroy
          layout_part.update(partable: text)
        end
      else
        layout_part.update(partable_type: 'Spina::Text')
      end
    end
  end

  def down
    Spina::LayoutPart.where(name: 'current_conference_alert', layout_partable_type: 'Spina::Text').each do |layout_part|
      if layout_part.partable.present?
        Spina::Line.create(content: layout_part.partable.content).then do |line|
          layout_part.partable.destroy
          layout_part.update(partable: line)
        end
      else
        layout_part.update(partable_type: 'Spina::Line')
      end
    end
  end
end

module Spina
  class LayoutPart < ::Spina::ApplicationRecord
    belongs_to :account
    belongs_to :layout_partable, polymorphic: true
  end

  class Line < ApplicationRecord
    extend Mobility
    translates :content, fallbacks: true
  end

  class Text < ApplicationRecord
    extend Mobility
    translates :content, fallbacks: true
  end
end
