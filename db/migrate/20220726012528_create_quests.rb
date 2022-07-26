class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.boolean :quest_cleared, default: false

      t.timestamps
    end
    add_index :quests, [:user_id, :post_id], unique: true
  end
end
