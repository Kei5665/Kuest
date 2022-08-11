class CreatePostEreas < ActiveRecord::Migration[7.0]
  def change
    create_table :post_ereas do |t|
      t.references :area, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
