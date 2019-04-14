class CreateReservationCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_coupons do |t|
      t.references :reservation, foreign_key: true
      t.references :coupon, foreign_key: true

      t.timestamps
    end
  end
end
