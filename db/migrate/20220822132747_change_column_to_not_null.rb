class ChangeColumnToNotNull < ActiveRecord::Migration[7.0]
  def up
    change_column :posts, :body, :text, null: true
  end

  def down
    change_column :posts, :body, :text, null: false
  end
end
