# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20190408131354)

class ChangeSpinaResources < ActiveRecord::Migration[6.0] #:nodoc:
  def up
    resource = Spina::Resource.find_or_create_by name: 'conference_pages', label: 'Conference pages'
    Spina::Conferences::Conference.all.each do |conference|
      conference.conference_page.update! parent: nil, resource: resource
    end
    resource = Spina::Resource.find_or_create_by name: 'conference_pages', label: 'Conference pages'
    Spina::Conferences::Presentation.all.each do |presentation|
      presentation.conference_page.update! parent: presentation.conference.conference_page, resource: resource
    end
    Spina::Resource.find_by(name: 'conferences')&.destroy
    Spina::Resource.find_by(name: 'presentations')&.destroy
  end

  def down
    conferences_resource = Spina::Resource.find_or_create_by name: 'conferences', label: 'Conferences',
                                                             view_template: 'conference'
    Spina::Conferences::Conference.all.each do |conference|
      conference.conference_page.update! parent: Spina::Page.find_by(view_template: 'conferences'),
                                         resource: conferences_resource
    end
    presentations_resource = Spina::Resource.find_or_create_by name: 'presentations', label: 'Presentations',
                                                               view_template: 'presentation'
    Spina::Conferences::Presentation.all.each do |presentation|
      presentation.conference_page.update! parent: presentation.conference.conference_page,
                                           resource: presentations_resource
    end
    Spina::Resource.find_by(name: 'conference_pages')&.destroy
  end
end
