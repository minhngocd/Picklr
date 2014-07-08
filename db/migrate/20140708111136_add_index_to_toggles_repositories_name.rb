class AddIndexToTogglesRepositoriesName < ActiveRecord::Migration
  def change
    add_index :toggles_repositories, :name, unique: true
  end
end
