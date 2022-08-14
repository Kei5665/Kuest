class AddAssetsPathColumnToEmblems < ActiveRecord::Migration[7.0]
  def change
    add_column :emblems, :assets_path, :string
  end
end
