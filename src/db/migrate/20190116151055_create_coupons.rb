class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.integer :coupon_id
      t.string :name
      t.string :coupon_fee
      t.integer :tax_id
      t.integer :coupon_remaining
      t.date :coupon_start_date
      t.date :coupon_start_end

      t.timestamps
    end
  end
end
