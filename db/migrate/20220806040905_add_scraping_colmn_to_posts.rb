class AddScrapingColmnToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :time, :string
    add_column :posts, :address, :string
    add_column :posts, :price, :string
  end
end
