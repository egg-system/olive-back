class Coupon < ApplicationRecord
    has_many :customer_coupons
    def bought_by_customer(customer_id)
        ticket_count = self.count
        customer_coupon = 
            self.customer_coupons.build(
                {
                    customer_id: customer_id,
                    expire_at: self.months_to_expire ?
                        Time.current.since(self.months_to_expire.month) : nil,
                    coupon_type_id: self.coupon_type_id
                }
            )
        ticket_count.times do |i|
            customer_coupon.customer_coupon_tickets.build
        end
        return customer_coupon.save
    end
end
