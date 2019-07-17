# frozen_string_literal: true
# This migration comes from spina_conferences (originally 20190704135524)

class AddConstraintsToColumns < ActiveRecord::Migration[6.0] #:nodoc:
  def change
    change_column_null :spina_conferences_conferences, :dates, false
    change_column_null :spina_conferences_conferences, :institution_id, false
    change_column_null :spina_conferences_delegates, :first_name, false
    change_column_null :spina_conferences_delegates, :last_name, false
    change_column_null :spina_conferences_delegates, :institution_id, false
    change_column_null :spina_conferences_dietary_requirements, :name, false
    change_column_null :spina_conferences_institutions, :name, false
    change_column_null :spina_conferences_institutions, :city, false
    change_column_null :spina_conferences_presentation_types, :name, false
    change_column_null :spina_conferences_presentation_types, :duration, false
    change_column_null :spina_conferences_presentation_types, :conference_id, false
    change_column_null :spina_conferences_presentations, :title, false
    change_column_null :spina_conferences_presentations, :abstract, false
    change_column_null :spina_conferences_presentations, :start_datetime, false
    change_column_null :spina_conferences_presentations, :room_use_id, false
    change_column_null :spina_conferences_rooms, :number, false
    change_column_null :spina_conferences_rooms, :building, false
    change_column_null :spina_conferences_rooms, :institution_id, false
  end
end
