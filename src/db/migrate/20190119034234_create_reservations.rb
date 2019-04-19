class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer :children_count, default: 0, comment: '随伴するお子様の数'
      t.text :reservation_comment
      
      t.references :store, foreign_key: true
      t.references :customer, foreign_key: true
      t.references :pregnant_state, foreign_key: true
      
      t.date :reservation_date
      t.time :start_time
      t.time :end_time

      t.date :deleted_at
      t.timestamps
    end
  end
end
