class CreateEmblems < ActiveRecord::Migration[7.0]
  def change
    create_table :emblems do |t|
      t.integer :limit_num, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
