class CreateCustomerCouponTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_coupon_tickets do |t|
      t.references :customer, foreign_key: true
      t.references :customer_coupon, foreign_key: true

      t.date :used_at

      t.timestamps
    end
  end
end
