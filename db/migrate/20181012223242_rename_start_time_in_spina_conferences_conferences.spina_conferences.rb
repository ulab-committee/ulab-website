# This migration comes from spina_conferences (originally 20181012214813)
class RenameStartTimeInSpinaConferencesConferences < ActiveRecord::Migration[5.2]
  def change
    rename_column :spina_conferences_presentations, :start_time, :start_datetime
  end
end
