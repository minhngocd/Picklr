class CreateEnvironmentsRepositories < ActiveRecord::Migration
  def change
    create_table :environments_repositories do |t|
      t.string :name

      t.timestamps
    end
  end
end
