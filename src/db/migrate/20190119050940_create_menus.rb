class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.integer :fee
      t.integer :service_minutes, comment: '施術時間(分)'
      t.date :service_start_date
      t.date :service_end_date
      t.references :menu_category, foreign_key: true
      t.text :memo

      t.timestamps
    end
  end
end
