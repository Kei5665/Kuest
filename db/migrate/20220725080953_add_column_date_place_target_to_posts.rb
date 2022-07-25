class AddColumnDatePlaceTargetToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :date, :datetime
    add_column :posts, :place, :string
    add_column :posts, :target, :string
  end
end
