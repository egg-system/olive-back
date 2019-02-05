class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.integer :store_id
      t.integer :store_type_id
      t.string :name
      t.text :address
      t.string :store_tel
      t.string :store_mail
      t.text :store_url
      t.date :business_hours_weekday
      t.date :business_hours_holiday
      t.date :last_reception_time_weekday
      t.date :last_reception_time_holiday

      t.timestamps
    end
  end
end
