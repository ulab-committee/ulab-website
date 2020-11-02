# frozen_string_literal: true

class SetPrimerTheme < ActiveRecord::Migration[6.0]
  def up
    accounts = Spina::Account.select { |account| account.theme == 'conference' }
    accounts.each do |account|
      preferences = account.preferences
      preferences[:theme] = 'conferences_primer_theme'
      account.update_columns(preferences: preferences)
    end
  end

  def down
    accounts = Spina::Account.select { |account| account.theme == 'conferences_primer_theme' }
    accounts.each do |account|
      preferences = account.preferences
      preferences[:theme] = 'conference'
      account.update_columns(preferences: preferences)
    end
  end
end
