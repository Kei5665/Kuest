class DivideLatlngIntoLatAndLngInPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :latlng, :jsonb
    add_column :posts, :latitude, :numeric
    add_column :posts, :longitude, :numeric
  end
end
