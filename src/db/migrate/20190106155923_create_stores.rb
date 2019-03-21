class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.integer :store_type, default: 0, comment: "モデル内でenum型に定義 0:直営店 1:FC店"
      t.string :name
      t.text :address
      t.string :tel
      t.string :mail
      t.text :url
      t.integer :open_at
      t.integer :close_at
      t.integer :break_from, comment: '休憩の開始時間'
      t.integer :break_to, comment: '休憩の終了時間'
      t.timestamps
    end
  end
end
