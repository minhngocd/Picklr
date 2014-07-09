class CreateTogglesValues < ActiveRecord::Migration
  def change
    create_table :toggles_values do |t|
      t.string :toggle_name, :null => false
      t.string :environment_name, :null => false
      t.boolean :value, :null => false

      t.timestamps
    end

    add_index :toggles_values, [:toggle_name, :environment_name], unique: true
  end
end
