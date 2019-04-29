class CustomerCoupon < ApplicationRecord
    belongs_to :coupon
    belongs_to :coupon_type
    belongs_to :customer
    has_many :customer_coupon_tickets

    scope :where_not_expire, -> {
      where('? <= expire_at OR expire_at IS NULL', Date.today)
    }

  scope :join_tickets_can_be_used, ->{
    joins(:customer_coupon_tickets).merge(CustomerCouponTicket.where_can_use)
  }
end
