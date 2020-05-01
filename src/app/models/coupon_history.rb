class CouponHistory < ApplicationRecord
  belongs_to :coupon
  belongs_to :customer

  scope :join_coupon, -> {
    left_joins(:coupon).select("coupons.name as coupon_name")
  }

  scope :join_customer, -> {
    left_joins(:customer).select("CONCAT(customers.first_name, customers.last_name) as customer_name")
  }

  scope :join_tables, -> {
    select('coupon_histories.*').join_coupon.join_customer
  }
end
