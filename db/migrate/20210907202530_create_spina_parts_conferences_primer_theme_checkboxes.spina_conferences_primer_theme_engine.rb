# frozen_string_literal: true
# This migration comes from spina_conferences_primer_theme_engine (originally 20210907142118)

class CreateSpinaPartsConferencesPrimerThemeCheckboxes < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    create_table :spina_parts_conferences_primer_theme_checkboxes, &:timestamps
  end
end
