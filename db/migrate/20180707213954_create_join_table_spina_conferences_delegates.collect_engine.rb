# This migration comes from collect_engine (originally 4)
class CreateJoinTableSpinaConferencesDelegates < ActiveRecord::Migration[5.2]
  def change
    create_join_table :conferences, :delegates, table_name: 'spina_conferences_delegates' do |t|
      # t.index [:spina_conference_id, :spina_delegate_id]
      # t.index [:spina_delegate_id, :spina_conference_id]
    end
  end
end
