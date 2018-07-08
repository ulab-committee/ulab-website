module Spina
  module Admin
    class ConferencesController < AdminController
      before_action :set_breadcrumbs

      def index
        @conferences = Conference.all
      end

      def new
        @conference = Conference.new
        add_breadcrumb I18n.t('spina.conferences.new')
      end

      def edit
        @conference = Conference.find(params[:id])
        add_breadcrumb @conference.institution_and_year
      end

      def create
        @conference = Conference.new(conference_params)
        add_breadcrumb I18n.t('spina.conferences.new')
        if @conference.save
          redirect_to admin_conferences_path
        else
          render :new
        end
      end

      def update
        @conference = Conference.find(params[:id])
        add_breadcrumb @conference.institution_and_year
        if @conference.update(conference_params)
          redirect_to admin_conferences_path
        else
          render :edit
        end
      end

      def destroy
        @conference = Conference.find(params[:id])
        @conference.destroy
        redirect_to admin_conferences_path
      end

      private

      def set_breadcrumbs
        add_breadcrumb I18n.t('spina.website.conferences'), admin_conferences_path
      end

      def conference_params
        params.require(:conference).permit(:start_date, :finish_date, :city, :institution, :spina_delegate_ids, :spina_presentation_ids)
      end

    end
  end
end

