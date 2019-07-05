class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_tweeted, :datetime, :default => DateTime.now
  end
end
