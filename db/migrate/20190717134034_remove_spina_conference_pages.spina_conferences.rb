# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20190701174807)

class RemoveSpinaConferencePages < ActiveRecord::Migration[6.0] #:nodoc:
  def up
    [*Spina::Conferences::Conference.all, *Spina::Conferences::Presentation.all].each do |pageable|
      migrate_page_parts_to_parts(pageable)
      conference_page = pageable.conference_page
      pageable.conference_page_part&.delete
      conference_page&.destroy
    end
    destroy_root_page
    Spina::Resource.destroy_by name: 'conference_pages', label: 'Conference pages'
    remove_column :spina_pages, :type
  end

  def down
    add_column :spina_pages, :type, :string
    resource = Spina::Resource.find_or_create_by name: 'conference_pages', label: 'Conference pages'
    create_root_page
    [*Spina::Conferences::Conference.all, *Spina::Conferences::Presentation.all].each do |pageable|
      pageable.conference_page =
        Spina::Conferences::ConferencePage.create(title: pageable.name, deletable: false, resource: resource,
                                                  view_template: pageable.class.name.demodulize.parameterize)
      migrate_parts_to_page_parts(pageable)
    end
  end

  def migrate_page_parts_to_parts(conference_pageable)
    page_parts = conference_pageable.conference_page&.page_parts
    page_parts&.each do |page_part|
      conference_pageable.parts.create title: page_part.title, name: page_part.name, partable: page_part.page_partable
      page_part.delete
    end
  end

  def migrate_parts_to_page_parts(conference_pageable)
    parts = conference_pageable.parts
    parts.each do |part|
      conference_pageable.conference_page.page_parts.create title: part.title, name: part.name,
                                                            page_partable: part.partable
      part.delete
    end
  end

  def create_root_page
    Spina::Page.find_or_create_by name: 'conferences', view_template: 'conferences' do |page|
      page.title = 'Conference'
      page.deletable = false
    end
  end

  def destroy_root_page
    root_page = Spina::Page.find_by name: 'conferences', view_template: 'conferences'
    root_page&.destroy
  end
end
