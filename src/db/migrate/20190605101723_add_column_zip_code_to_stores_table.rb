class AddColumnZipCodeToStoresTable < ActiveRecord::Migration[5.2]
  def up
    add_column :stores, :zip_code, :string
  end

  def down
    remove_column :stores, :zip_code, :string
  end
end
