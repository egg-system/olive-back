class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.integer :store_type, comment: "モデル内でenum型に定義 0:直営店 1:FC店"
      t.string :name
      t.text :address
      t.string :tel
      t.string :mail
      t.text :url
      t.text :infomation
      t.timestamps
    end
  end
end
