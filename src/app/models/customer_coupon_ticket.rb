class CustomerCouponTicket < ApplicationRecord
    belongs_to :customer_coupon
    scope :where_can_use, -> {
      where('used_at is NULL')
    }
end
