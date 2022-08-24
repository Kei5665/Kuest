class AddAttributesColumnToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :availability, :boolean, default: false
  end
end
