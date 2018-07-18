module Spina
  module Admin
    class PresentationsController < AdminController
      before_action :set_breadcrumbs

      def index
        @presentations = Presentation.all
      end

      def new
        @presentation = Presentation.new
        add_breadcrumb I18n.t('spina.presentations.new')
      end

      def edit
        @presentation = Presentation.find(params[:id])
        add_breadcrumb @presentation.title
      end

      def create
        @presentation = Presentation.new(presentation_params)
        add_breadcrumb I18n.t('spina.presentations.new')
        if @presentation.save
          redirect_to admin_presentations_path
        else
          render :new
        end
      end

      def update
        @presentation = Presentation.find(params[:id])
        add_breadcrumb @presentation.title
        if @presentation.update(presentation_params)
          redirect_to admin_presentations_path
        else
          render :edit
        end
      end

      def destroy
        @presentation = Presentation.find(params[:id])
        @presentation.destroy
        redirect_to admin_presentations_path
      end

      def conference_dates
        @conference = Conference.find_by(id: params[:conference_id])
        respond_to do |format|
          format.json do
            render json: @conference.dates.collect { |date| { label: l(date, format: :short), date: date.strftime("%Y-%m-%d") } }
          end
        end
      end

      private

        def set_breadcrumbs
          add_breadcrumb I18n.t('spina.website.presentations'), admin_presentations_path
        end

        def presentation_params
          params.require(:presentation).permit(:title, :date, :start_time, :abstract, :type, :spina_conference_id, delegate_ids: [])
        end

    end
  end
end
