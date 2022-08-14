class AddAssetsPathColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :assets_path, :string, default: "/assets/yuusya1.png"
  end
end
