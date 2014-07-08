class CreateTogglesRepositories < ActiveRecord::Migration
  def change
    create_table :toggles_repositories do |t|
      t.string :name,
      t.string :display_name
      t.text :description

      t.timestamps
    end
  end
end
