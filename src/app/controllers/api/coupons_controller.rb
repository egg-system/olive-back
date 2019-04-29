class Api::CouponsController < Api::ApiController
  include Concerns::TokenAuthenticable

  def index
    render json: { 
      status: 'success', 
      data: CouponType.count_remains_of_tickets_by_customer(current_api_customer.id) 
    }
  end

end
