# frozen_string_literal: true

module Spina
  module Conferences
    # This class serves presentations as iCal
    class ConferencesController < ApplicationController
      def index
        @conferences = Spina::Conferences::Conference.sorted
        @calendar_name = "#{current_account.name} Conferences"
        respond_to(&:ics)
      end

      def show
        @conference = Spina::Conferences::Conference.find(params[:id])
        @calendar_name = "#{current_account.name} #{@conference.name}"
        respond_to(&:ics)
      end
    end
  end
end
