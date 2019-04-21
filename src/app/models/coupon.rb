class Coupon < ApplicationRecord
    def bought_by_customer(customer_id)
        ticket_count = self.count
        customer_coupon = CustomerCoupon.new
        customer_coupon.coupon_id = self.id
        customer_coupon.coupon_type_id = self.coupon_type_id
        customer_coupon.customer_id = customer_id
        if self.months_to_expire then
            customer_coupon.expire_at = Time.current.since(self.months_to_expire.month)
        end
        if !customer_coupon.save then
            return false
        end
        ticket_count.times do |i|
            customer_coupon_ticket = CustomerCouponTicket.new
            customer_coupon_ticket.customer_coupon = customer_coupon
            if !customer_coupon_ticket.save then
                return false
            end
        end
    end
end
