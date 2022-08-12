class AddColumnAreaIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :area, foreign_key: true
  end
end
