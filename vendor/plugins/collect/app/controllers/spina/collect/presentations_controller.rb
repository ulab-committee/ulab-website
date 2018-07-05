module Spina
  module Collect
    class PresentationsController < ::Spina::ApplicationController
      def index
        @presentations = Presentation.all
      end
      def show
        @presentations ||= Presentation.find(params[:id])
      end
    end
  end
end
