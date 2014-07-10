class CreateTogglesRepositories < ActiveRecord::Migration
  def change
    create_table :toggles_repositories do |t|
      t.string :feature_name, :null => false
      t.string :environment_name, :null => false
      t.boolean :value, :null => false, :default => false

      t.timestamps
    end

    add_index :toggles_repositories, [:feature_name, :environment_name], unique: true
  end
end
