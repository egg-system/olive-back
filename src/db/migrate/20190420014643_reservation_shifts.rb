class ReservationShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_shifts do |t|
      t.references :reservation, on_delete: :cascade, foreign_key: true
      t.references :shift, on_delete: :cascade, foreign_key: true

      t.timestamps
    end
  end
end
