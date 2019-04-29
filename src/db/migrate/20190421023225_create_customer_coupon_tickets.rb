class CreateCustomerCouponTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_coupon_tickets do |t|
      t.references :customer_coupon, foreign_key: {on_delete: :cascade}

      t.date :used_at

      t.timestamps
    end
  end
end
