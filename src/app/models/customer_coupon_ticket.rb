class CustomerCouponTicket < ApplicationRecord
    belongs_to :customer_coupon
    scope :where_can_use, -> {
      where('expire_at is NULL')
    }
end
