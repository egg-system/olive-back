class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.integer :store_id
      t.string :name
      t.text :menu_description
      t.integer :menu_fee
      t.time :service_time
      t.date :service_start_date
      t.date :service_end_date
      t.integer :menu_category_id
      t.text :memo

      t.timestamps
    end
  end
end
