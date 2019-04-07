class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer :children_count, comment: '随伴するお子様の数'
      t.boolean :double_select, comment: '二枠予約かどうか'
      t.date :reservation_date
      t.date :first_visited_at
      t.time :start_at
      t.time :end_at
      t.text :reservation_comment
      t.boolean :is_canceled
      t.integer :total_fee
      t.references :customer, foreign_key: true
      t.references :staff, foreign_key: true
      t.references :coupon, foreign_key: true
      t.references :pregnant_state, foreign_key: true

      t.timestamps
    end
  end
end
