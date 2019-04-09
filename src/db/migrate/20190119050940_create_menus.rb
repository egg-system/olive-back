class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.integer :fee
      t.integer :service_minutes, comment: '施術時間(分)'
      t.date :start_at
      t.date :end_at
      t.references :menu_category, foreign_key: true
      t.references :skill, foreign_key: true, default: 1, comment: '必須スキルを紐づける'
      t.text :memo

      t.timestamps
    end
  end
end
