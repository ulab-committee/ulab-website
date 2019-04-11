# frozen_string_literal: true

module Spina
  module Conferences
    # This class serves presentations as iCal
    class PresentationsController < ApplicationController
      def index
        params[:conference_id] ? set_conference_presentations : set_presentations
        respond_to(&:ics)
      end

      private

      def set_conference_presentations
        @conference = Spina::Conferences::Conference.find(params[:conference_id])
        @presentations = @conference.presentations
        @calendar_name = "#{current_account.name} #{@conference.name} Presentations"
      end

      def set_presentations
        @presentations = Spina::Conferences::Presentation.sorted
        @calendar_name = "#{current_account.name} Presentations"
      end
    end
  end
end
