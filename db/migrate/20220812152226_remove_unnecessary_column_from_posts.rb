class RemoveUnnecessaryColumnFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :target, :string
    remove_column :posts, :user_id, :bigint
  end
end
