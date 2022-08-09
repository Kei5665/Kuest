class CreateUserEmblems < ActiveRecord::Migration[7.0]
  def change
    create_table :user_emblems do |t|
      t.references :user, null: false, foreign_key: true
      t.references :emblem, null: false, foreign_key: true

      t.timestamps
    end
  end
end
