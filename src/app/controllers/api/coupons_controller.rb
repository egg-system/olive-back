class Api::CouponsController < Api::ApiController
  include Concerns::TokenAuthenticable

  def index
    ret = Hash.new

    CouponType.all.each do |coupon_type|
      count_result = coupon_type.
        customer_coupons.
        where_not_expire.
        where(customer_id: current_api_customer.id).
        join_tickets_can_be_used.
        group('expire_at').
        count

      unless count_result.empty? then
        arr = []
        count_result.each do|expire_at, count|
          arr.push({'count' => count, 'expire' => expire_at})
        end
        ret[coupon_type.type_code] = arr
      end
    end

    render json: { status: 'success', data: ret }
  end

end
