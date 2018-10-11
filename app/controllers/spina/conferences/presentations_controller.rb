# frozen_string_literal: true

module Spina
  module Conferences
    # This class serves presentations as iCal
    class PresentationsController < ApplicationController
      def index
        if params[:conference_id]
          @conference =
            Spina::Conferences::Conference.find(params[:conference_id])
          @presentations = @conference.presentations
          @calendar_name =
            "#{current_account.name} #{@conference.name} Presentations"
        else
          @presentations = Spina::Conferences::Presentation.sorted
          @calendar_name = "#{current_account.name} Presentations"
        end
        respond_to { |format| format.ics }
      end
    end
  end
end
