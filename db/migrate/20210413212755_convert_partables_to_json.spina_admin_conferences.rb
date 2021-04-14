# frozen_string_literal: true
# This migration comes from spina_admin_conferences (originally 20210315164411)

# Reregistering parts necessary due to deserialization from JSON, where class instances from registration used
Spina::Part.all.delete_if { |part| Spina::Parts::Admin::Conferences.constants.include? :"#{part.name.demodulize}" }
Spina::Part.register(Spina::Parts::Admin::Conferences::Date)
Spina::Part.register(Spina::Parts::Admin::Conferences::EmailAddress)
Spina::Part.register(Spina::Parts::Admin::Conferences::Time)
Spina::Part.register(Spina::Parts::Admin::Conferences::Url)

# This migration converts table-based partables from Spina v1 to the new JSON-based parts in Spina v2.
# If you have custom partables you must modify this migration to ensure the conversion of your partables is handled appropriately
# by implementing <tt>convert_to_json!</tt> for your partables.
class ConvertPartablesToJson < ActiveRecord::Migration[6.1]
  def up # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    announce 'converting partables to JSON parts'
    Spina.config.locales.each do |locale|
      I18n.with_locale(locale) do
        say_with_time "Migrating content in locale #{I18n.locale}..." do
          Spina::Page.in_batches.each_record do |page|
            say "Migrating page parts for \"#{page.title}\"...", true
            page.convert_page_parts_to_json!
          end
          Spina::Account.in_batches.each_record do |account|
            say "Migrating layout parts for \"#{account.name}\"...", true
            account.convert_layout_parts_to_json!
          end
          Spina::Admin::Conferences::Conference.in_batches.each_record do |conference|
            say "Migrating parts for \"#{conference.name}\"...", true
            conference.convert_parts_to_json!
          end
          Spina::Admin::Conferences::Presentation.in_batches.each_record do |presentation|
            say "Migrating parts for \"#{presentation.title}\"...", true
            presentation.convert_parts_to_json!
          end
        end
      end
    end
  end

  def down # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    announce 'converting JSON parts to partables'
    Spina.config.locales.each do |locale|
      I18n.with_locale(locale) do
        say_with_time "Migrating content in locale #{I18n.locale}..." do
          Spina::Page.in_batches.each_record do |page|
            say "Migrating JSON parts for \"#{page.title}\"...", true
            page.convert_json_to_parts!
          end
          Spina::Account.in_batches.each_record do |account|
            say "Migrating JSON parts for \"#{account.name}\"...", true
            account.convert_json_to_parts!
          end
          Spina::Admin::Conferences::Conference.in_batches.each_record do |conference|
            say "Migrating JSON parts for \"#{conference.name}\"...", true
            conference.convert_json_to_parts!
          end
          Spina::Admin::Conferences::Presentation.in_batches.each_record do |presentation|
            say "Migrating JSON parts for \"#{presentation.title}\"...", true
            presentation.convert_json_to_parts!
          end
        end
      end
    end
  end
end

module Spina # :nodoc: all
  class ImageCollectionsImage < Spina::ApplicationRecord
    belongs_to :image
    belongs_to :image_collection
  end

  class AttachmentCollectionsAttachment < Spina::ApplicationRecord
    belongs_to :attachment
    belongs_to :attachment_collection
  end

  class Attachment < ApplicationRecord
    def convert_to_json!
      Parts::Attachment.new(attachment_id: id, signed_blob_id: file.blob.signed_id, filename: file.blob.filename)
    end
  end

  class AttachmentCollection < ApplicationRecord
    has_many :attachment_collection_attachments
    has_many :attachments, through: :attachment_collection_attachments

    def convert_to_json!
      Parts::Repeater.new(content: attachments.collect(&:convert_to_json!)
                                              .collect { |attachment| RepeaterContent.new(parts: [attachment]) })
    end
  end

  class Image < ApplicationRecord
    def convert_to_json!
      Parts::Image.new(image_id: id, signed_blob_id: file.blob.signed_id, filename: file.blob.filename)
    end
  end

  class ImageCollection < ApplicationRecord
    has_many :image_collections_images
    has_many :images, through: :image_collections_images

    def convert_to_json!
      Parts::ImageCollection.new(images: images.order(:position).collect(&:convert_to_json!))
    end
  end

  class Line < ApplicationRecord
    extend Mobility
    translates :content, fallbacks: true

    def convert_to_json!
      Parts::Line.new(content: content)
    end
  end

  class Option < ApplicationRecord
    def convert_to_json!
      Parts::Option.new(content: content)
    end

    private

    def content
      I18n.t(['options', part.name, value].compact.join('.'))
    end

    def part
      page_part || layout_part || structure_part
    end
  end

  class Structure < ApplicationRecord
    has_many :structure_items
    has_one :page_part, as: :page_partable
    has_one :layout_part, as: :layout_partable
    has_one :part, as: :partable, class_name: 'Spina::Admin::Conferences::Part'

    def convert_to_json!
      Parts::Repeater.new(content: structure_items.order(:position)
                                                  .collect(&:convert_to_json!)
                                                  .each { |structure_item| structure_item.name = present_part.name })
    end

    def present_part
      page_part || layout_part || part
    end
  end

  class Text < ApplicationRecord
    extend Mobility
    translates :content, fallbacks: true

    def convert_to_json!
      Parts::Text.new(content: content)
    end
  end

  class LayoutPart < ::Spina::ApplicationRecord
    belongs_to :account
    belongs_to :layout_partable, polymorphic: true

    def convert_to_json!
      raise <<~MESSAGE unless layout_partable.respond_to? :convert_to_json!
        Cannot convert an instance of #{layout_partable_type} to JSON.
        You need to modify #{__FILE__} and implement `convert_to_json!` for this partable.
      MESSAGE

      layout_partable.convert_to_json!.tap { |layout_partable| layout_partable.name = name }
    end
  end

  class PagePart < ::Spina::ApplicationRecord
    belongs_to :page
    belongs_to :page_partable, polymorphic: true

    def convert_to_json!
      raise <<~MESSAGE unless page_partable.respond_to? :convert_to_json!
        Cannot convert an instance of #{page_partable_type} to JSON.
        You need to modify #{__FILE__} and implement `convert_to_json!` for this partable.
      MESSAGE

      page_partable.convert_to_json!.tap { |page_partable| page_partable.name = name }
    end
  end

  class StructurePart < ::Spina::ApplicationRecord
    belongs_to :structure_item
    belongs_to :structure_partable, polymorphic: true

    def convert_to_json!
      raise <<~MESSAGE unless structure_partable.respond_to? :convert_to_json!
        Cannot convert an instance of #{structure_partable_type} to JSON.
        You need to modify #{__FILE__} and implement `convert_to_json!` for this partable.
      MESSAGE

      structure_partable.convert_to_json!.tap { |structure_partable| structure_partable.name = name }
    end
  end

  class Page < Spina::ApplicationRecord
    has_many :page_parts

    def convert_page_parts_to_json!
      page_parts.reject { |page_part| page_part.page_partable.nil? }
                .collect(&:convert_to_json!)
                .compact
                .then { |parts| send(:"#{I18n.locale}_content").union(parts) }
                .then { |parts| update("#{I18n.locale}_content": parts) }
    end

    def convert_json_to_parts!
      update(page_parts: send(:"#{I18n.locale}_content").collect(&:convert_to_partable!)
                                                        .compact
                                                        .collect { |partable| PagePart.new(page_partable: partable) })
    end
  end

  class Account < Spina::ApplicationRecord
    has_many :layout_parts

    def convert_layout_parts_to_json!
      layout_parts.reject { |layout_part| layout_part.layout_partable.nil? }
                  .collect(&:convert_to_json!)
                  .compact
                  .then { |parts| send(:"#{I18n.locale}_content").union(parts) }
                  .then { |parts| update("#{I18n.locale}_content": parts) }
    end

    def convert_json_to_parts!
      update(layout_parts: send(:"#{I18n.locale}_content")
                             .collect(&:convert_to_partable!)
                             .compact
                             .collect { |partable| LayoutPart.new(layout_partable: partable) })
    end
  end

  class StructureItem < Spina::ApplicationRecord
    belongs_to :structure
    has_many :structure_parts

    def convert_to_json!
      Parts::RepeaterContent.new(parts: structure_parts.reject { |structure_part| structure_part.structure_partable.nil? }
                                                       .collect(&:convert_to_json!)
                                                       .compact)
    end
  end

  module Parts # :nodoc: all
    class Attachment < Base
      def convert_to_partable!
        Spina::Attachment.find(attachment_id)
      end
    end

    class Image < Base
      def convert_to_partable!
        Spina::Image.find(image_id)
      end
    end

    class ImageCollection < Base
      def convert_to_partable!
        Spina::ImageCollection.new(images: images.collect(&:convert_to_partable!))
      end
    end

    class Line < Base
      def convert_to_partable!
        Spina::Line.new(content: content)
      end
    end

    class MultiLine < Base
      def convert_to_partable!
        Spina::Text.new(content: content)
      end
    end

    class Text < Base
      def convert_to_partable!
        Spina::Text.new(content: content)
      end
    end

    class Option < Base
      def convert_to_partable!
        Spina::Option.new(content: content)
      end
    end

    class Repeater < Base
      def convert_to_partable!
        Spina::Structure.new(structure_items: content.collect(&:convert_to_structure_item!))
      end
    end

    class RepeaterContent < Base
      def convert_to_structure_item!
        Spina::StructureItem.new(structure_parts: parts.collect(&:convert_to_partable!)
                                                       .compact
                                                       .collect { |partable| StructurePart.new(structure_partable: partable) })
      end
    end

    module Admin
      module Conferences
        class Date < Spina::Parts::Base
          def convert_to_partable!
            Spina::Admin::Conferences::DatePart.new(content: content)
          end
        end

        class EmailAddress < Spina::Parts::Base
          def convert_to_partable!
            Spina::Admin::Conferences::EmailAddressPart.new(content: content)
          end
        end

        class Time < Spina::Parts::Base
          def convert_to_partable!
            Spina::Admin::Conferences::TimePart.new(content: content)
          end
        end

        class Url < Spina::Parts::Base
          def convert_to_partable!
            Spina::Admin::Conferences::UrlPart.new(content: content)
          end
        end
      end
    end
  end

  module Admin
    module Conferences
      class DatePart < ApplicationRecord
        def convert_to_json!
          Spina::Parts::Admin::Conferences::Date.new(content: content)
        end
      end

      class EmailAddressPart < ApplicationRecord
        def convert_to_json!
          Spina::Parts::Admin::Conferences::EmailAddress.new(content: content)
        end
      end

      class TimePart < ApplicationRecord
        def convert_to_json!
          Spina::Parts::Admin::Conferences::Time.new(content: content)
        end
      end

      class UrlPart < ApplicationRecord
        def convert_to_json!
          Spina::Parts::Admin::Conferences::Url.new(content: content)
        end
      end

      class Part < ApplicationRecord
        belongs_to :pageable, polymorphic: true
        belongs_to :partable, polymorphic: true

        def convert_to_json!
          raise <<~MESSAGE unless partable.respond_to? :convert_to_json!
            Cannot convert an instance of #{partable_type} to JSON.
            You need to modify #{__FILE__} and implement `convert_to_json!` for this partable.
          MESSAGE

          partable.convert_to_json!.tap { |partable| partable.name = name }
        end
      end

      module Pageable
        extend ActiveSupport::Concern

        included do
          has_many :parts, as: :pageable

          def convert_parts_to_json!
            parts.reject { |part| part.partable.nil? }
                 .collect(&:convert_to_json!)
                 .compact
                 .then { |parts| send(:"#{I18n.locale}_content").union(parts) }
                 .then { |parts| update("#{I18n.locale}_content": parts) }
          end

          def convert_json_to_parts!
            update(parts: send(:"#{I18n.locale}_content").collect(&:convert_to_partable!)
                                                         .compact
                                                         .collect { |partable| Part.new(partable: partable) })
          end
        end
      end

      class Conference < ApplicationRecord
        include Pageable
      end

      class Presentation < ApplicationRecord
        include Pageable
      end
    end
  end
end
