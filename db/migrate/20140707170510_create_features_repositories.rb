class CreateFeaturesRepositories < ActiveRecord::Migration
  def change
    create_table :features_repositories do |t|
      t.string :name, :null => false
      t.text :description

      t.timestamps
    end

    add_index :features_repositories, :name, unique: true
  end
end
