# This migration comes from spina_conferences (originally 20181012190811)
class RenameSpinaConferencesPageParts < ActiveRecord::Migration[5.2]
  def change
    rename_table 'spina_conferences_dates', 'spina_conferences_date_parts'
    rename_table 'spina_conferences_email_addresses', 'spina_conferences_email_address_parts'
    rename_table 'spina_conferences_urls', 'spina_conferences_url_parts'
    rename_table 'spina_conferences_times', 'spina_conferences_time_parts'
  end
end
