class CreateReservationCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_coupons do |t|
      t.references :reservation, foreign_key: { on_delete: :cascade }
      t.references :coupon, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
