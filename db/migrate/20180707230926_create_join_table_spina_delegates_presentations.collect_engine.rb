# This migration comes from collect_engine (originally 5)
class CreateJoinTableSpinaDelegatesPresentations < ActiveRecord::Migration[5.2]
  def change
    create_join_table :delegates, :presentations, table_name: 'spina_delegates_presentations' do |t|
      # t.index [:spina_delegate_id, :spina_presentation_id]
      # t.index [:spina_presentation_id, :spina_delegate_id]
    end
  end
end
