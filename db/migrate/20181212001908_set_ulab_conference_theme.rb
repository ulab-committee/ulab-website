# frozen_string_literal: true

class SetUlabConferenceTheme < ActiveRecord::Migration[5.2] # :nodoc:
  def up
    *@accounts = Spina::Account.find { |account| account.theme == 'conference' }
    @accounts&.each do |account|
      account.update_attribute :theme, 'ulab_conference'
    end
  end

  def down
    *@accounts = Spina::Account.find do |account|
      account.theme == 'ulab_conference'
    end
    @accounts&.each { |account| account.update_attribute :theme, 'conference' }
  end
end
