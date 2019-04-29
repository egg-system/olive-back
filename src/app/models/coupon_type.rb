class CouponType < ApplicationRecord
    has_many :customer_coupons

    def self.count_remains_of_tickets_by_customer(customer_id)
        ret = []
        self.all.each do |coupon_type|
            ret_coupon_type = Hash.new
            ret_coupon_type['id'] = coupon_type.id
            ret_coupon_type['name'] = coupon_type.name
            count_result = coupon_type.
              customer_coupons.
              where_not_expire.
              where(customer_id: customer_id).
              join_tickets_can_be_used.
              group('expire_at').
              count
      
            arr = []
            unless count_result.empty? then
              count_result.each do|expire_at, count|
                arr.push({'count' => count, 'expire' => expire_at})
              end
            end
            ret_coupon_type['remains'] = arr
            ret.push(ret_coupon_type)
        end
        return ret
    end
end
