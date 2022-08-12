class RemoveUnnecessaryColumnFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :target, :string
    remove_column :posts, :user_id, :references
    remove_column :posts, :url, :string
  end
end
