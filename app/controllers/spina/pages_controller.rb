module Spina
  class PagesController < Spina::ApplicationController
    include Spina::Frontend

    before_action :current_spina_user_can_view_page?, except: [:robots]
    before_action { prepend_view_path "app/views/#{current_theme.name}" }

    helper_method :page

    def homepage
      render_with_template(page)
    end

    private

    def current_spina_user_can_view_page?
      raise ActiveRecord::RecordNotFound unless current_spina_user.present? || page.live?
    end
  end
end
