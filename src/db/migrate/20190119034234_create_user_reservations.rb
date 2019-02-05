class CreateUserReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_reservations do |t|
      t.integer :reservation_id
      t.integer :customer_id
      t.integer :staff_id
      t.integer :coupon_id
      t.boolean :first_visit_flg
      t.integer :pregnant_status_id
      t.integer :with_child_status_id
      t.boolean :double_flg
      t.date :reservation_date
      t.time :start_time
      t.time :end_time
      t.text :reservation_comment
      t.boolean :cancel_flg
      t.integer :total_fee
      t.time :total_time

      t.timestamps
    end
  end
end
