class CreateJoinTableSpinaConferencesDelegates < ActiveRecord::Migration[5.2]
  def change
    create_join_table :spina_conferences, :spina_delegates do |t|
      # t.index [:spina_conference_id, :spina_delegate_id]
      # t.index [:spina_delegate_id, :spina_conference_id]
    end
  end
end
