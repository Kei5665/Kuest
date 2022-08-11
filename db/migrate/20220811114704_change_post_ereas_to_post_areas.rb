class ChangePostEreasToPostAreas < ActiveRecord::Migration[7.0]
  def change
    rename_table :post_ereas, :post_areas
  end
end
