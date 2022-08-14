class AddAssetsPathColumnToEmblems < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :assets_path, :string,de
  end
end
