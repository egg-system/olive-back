class CreateStoreMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :store_menus do |t|
      t.references :store, foreign_key: true
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end
