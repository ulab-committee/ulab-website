# frozen_string_literal: true

class SetUlabConferenceTheme < ActiveRecord::Migration[5.2] # :nodoc:
  def up
    Spina::Account.all
      .select { |account| account.theme == 'conference' }
      .each { |account| account.update_attribute :theme, 'ulab_conference' }
  end

  def down
    Spina::Account.all
      .select { |account| account.theme == 'ulab_conference' }
      .each { |account| account.update_attribute :theme, 'conference' }
  end
end
