class CreateCustomerCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_coupons do |t|
      t.references :customer, foreign_key: true
      t.references :coupon, foreign_key: true
      t.references :coupon_type, foreign_key: true
      t.date :expire_at

      t.timestamps
    end
  end
end
