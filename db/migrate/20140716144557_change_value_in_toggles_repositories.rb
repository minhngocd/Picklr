class ChangeValueInTogglesRepositories < ActiveRecord::Migration
  def change
    rename_column :toggles_repositories, :value, :next_value
  end
end
