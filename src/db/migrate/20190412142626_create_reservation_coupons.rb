class CreateReservationCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_coupons do |t|
      t.references :reservation, on_delete: :cascade, foreign_key: true
      t.references :coupon, on_delete: :cascade, foreign_key: true

      t.timestamps
    end
  end
end
