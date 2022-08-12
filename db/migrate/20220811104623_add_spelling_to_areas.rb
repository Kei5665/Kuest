class AddSpellingToAreas < ActiveRecord::Migration[7.0]
  def change
    add_column :areas, :spelling, :string, null: false
  end
end
