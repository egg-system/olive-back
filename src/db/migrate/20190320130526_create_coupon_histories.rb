class CreateCouponHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_histories do |t|
      t.references :customer, foreign_key: true
      t.references :coupon, foreign_key: true
      t.date :used_at
      t.timestamps
    end
  end
end
