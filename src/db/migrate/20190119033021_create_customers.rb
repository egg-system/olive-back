class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.integer :costomer_id
      t.string :customer_first_name
      t.string :customer_last_name
      t.string :customer_first_name_kana
      t.string :customer_last_name_kana
      t.string :tel
      t.string :mail1
      t.string :mail2
      t.boolean :mail_receive_flg
      t.date :birthday
      t.string :zip_code
      t.string :prefecture
      t.text :city
      t.text :address
      t.boolean :membership_flg
      t.boolean :mail_flg
      t.text :comment1
      t.text :comment2
      t.integer :fitsrt_visit_store_id
      t.integer :last_visit_store_id
      t.date :last_visit_date

      t.timestamps
    end
  end
end
