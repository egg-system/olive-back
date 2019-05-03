class Api::ReservationsController < Api::ApiController
  include Concerns::TokenAuthenticable
  # TODO: customerが非会員かどうかに応じて、認証処理を追加する
  skip_before_action :authenticate_api_customer!
  
  def create
    reservation = Reservation.new(reservation_params)
    reservation.build_shifts
    reservation.save!
  end

  def index
    render json: Reservation
      .where(customer_id: params[:customer_id])
      .paginate(params[:page])
      .order_reserved_at
  end
  
  private

  def reservation_params
    params.permit(
      :customer_id,
      :pregnant_state_id,
      :children_count,
      :reservation_comment,
      :reservation_date,
      :start_time,
      :is_first,
      coupon_ids: [],
      reservation_details_attributes: [
        :store_id,
        :menu_id, 
        :mimitsubo_count,
        option_ids: [],
      ]
    )
  end
end
