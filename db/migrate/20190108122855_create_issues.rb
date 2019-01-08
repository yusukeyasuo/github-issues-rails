class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.references :repository, index: true, foreign_key: true, null: false
      t.string :title
      t.string :body
      t.string :html_url

      t.timestamps
    end
  end
end
