class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_tweeted, :datetime, :default => DateTime.now - 1.day
  end
end
