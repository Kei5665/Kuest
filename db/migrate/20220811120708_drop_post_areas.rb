class DropPostAreas < ActiveRecord::Migration[7.0]
  def change
    drop_table :post_areas do |t|
      t.references :area, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
