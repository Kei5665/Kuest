class DropProducts < ActiveRecord::Migration[7.0]
  def change
    drop_table :products do |t|
      t.string :name
      t.string :unit
      t.integer :price
      t.boolean :availability

      t.timestamps
    end
  end
end
