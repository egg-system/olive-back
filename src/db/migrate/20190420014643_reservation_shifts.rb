class ReservationShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_shifts do |t|
      t.references :reservation, foreign_key: { on_delete: :cascade }
      t.references :shift, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
