class DropStamps < ActiveRecord::Migration[7.0]
  def change
    drop_table :stamps do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.boolean :stamped, default: false

      t.timestamps
    end
  end
end
