class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.integer :store_type, comment: "モデル内でenum型に定義 0:直営店 1:FC店"
      t.string :name
      t.text :address
      t.string :tel
      t.string :mail
      t.text :url
      t.time :weekday_first_reception_time
      t.time :holiday_first_reception_time
      t.time :weekday_last_reception_time
      t.time :holiday_last_reception_time

      t.timestamps
    end
  end
end
