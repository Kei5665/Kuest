class AddClearNumToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :clear_num, :integer, null: false, default: 0 
  end
end
