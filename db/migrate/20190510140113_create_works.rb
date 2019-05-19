class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.integer :user_id
      t.text :body, :default => ""
      t.string :genre

      t.timestamps
    end
  end
end
