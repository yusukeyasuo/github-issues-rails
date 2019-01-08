class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :owner
      t.string :repository

      t.timestamps
    end
  end
end
