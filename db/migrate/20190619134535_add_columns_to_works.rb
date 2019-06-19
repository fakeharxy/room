class AddColumnsToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :prompt, :string
    add_column :works, :show_prompt, :boolean, :default => true
  end
end
