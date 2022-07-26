class ChangeDateToStringToPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :date, :string
  end
end
