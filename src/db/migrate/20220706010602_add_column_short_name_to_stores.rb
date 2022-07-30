class AddColumnShortNameToStores < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :short_name, :string
  end
end
