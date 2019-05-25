# frozen_string_literal: true

class MenuPresenter < Spina::MenuPresenter
  attr_reader :request
  attr_accessor :inactive_link_tag_css

  def initialize(collection, request)
    super(collection)
    @request = request
  end

  def render_items(collection)
    collection.inject(ActiveSupport::SafeBuffer.new) do |buffer, item|
      buffer << render_item(item)
    end
  end

  def render_item(item)
    link_to_unless_current item.menu_title, item.materialized_path,
                           class: link_tag_css, data: { page_id: item.page_id, draft: (true if item.draft?) } do
                             link_to item.menu_title, item.materialized_path,
                                     class: inactive_link_tag_css,
                                     data: { page_id: item.page_id, draft: (true if item.draft?) }
                           end
  end
end
