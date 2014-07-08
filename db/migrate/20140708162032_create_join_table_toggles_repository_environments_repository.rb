class CreateJoinTableTogglesRepositoryEnvironmentsRepository < ActiveRecord::Migration
  def change
    create_join_table :toggles_repositories, :environments_repositories do |t|
      t.index [:toggles_repository_id, :environments_repository_id], name: "toggle_value_index"
      t.boolean :value

      t.timestamp
    end
  end
end
