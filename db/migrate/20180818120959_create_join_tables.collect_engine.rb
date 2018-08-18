# This migration comes from collect_engine (originally 6)
class CreateJoinTables < ActiveRecord::Migration[5.2]
  def change
    create_join_table :spina_conferences, :spina_delegates, table_name: 'spina_conferences_delegates'
    create_join_table :spina_delegates, :spina_presentations, table_name: 'spina_delegates_presentations'
    create_join_table :spina_delegates, :spina_dietary_requirements, table_name: 'spina_delegates_dietary_requirements'
  end
end
