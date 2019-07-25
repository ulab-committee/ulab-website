# frozen_string_literal: true

class SetNewTheme < ActiveRecord::Migration[6.0] #:nodoc:
  def up
    accounts = Spina::Account.select { |account| account.theme == 'ulab_conference' }
    accounts.each do |account|
      preferences = account.preferences
      preferences[:theme] = 'conference'
      account.update_columns(preferences: preferences)
    end
  end

  def down
    accounts = Spina::Account.select { |account| account.theme == 'conference' }
    accounts.each do |account|
      preferences = account.preferences
      preferences[:theme] = 'ulab_conference'
      account.update_columns(preferences: preferences)
    end
  end
end
