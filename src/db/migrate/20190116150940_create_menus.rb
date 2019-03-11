class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.integer :store_id
      t.string :name
      t.text :menu_description
      t.integer :menu_fee
      t.integer :tax_id, defalt: 2, comment: '消費税。0.08%なのでデフォルト値は2'
      t.time :service_time
      t.date :service_start_date
      t.date :service_end_date
      t.integer :menu_category_id
      t.text :memo

      t.timestamps
    end
  end
end
