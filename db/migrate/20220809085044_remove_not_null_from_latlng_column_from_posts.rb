class RemoveNotNullFromLatlngColumnFromPosts < ActiveRecord::Migration[7.0]
  def change
    def up
      change_column :posts, :latlng, :jsonb, null: true
    end
  
    def down
      change_column :posts, :latlng, :jsonb, null: false
    end
  end
end
