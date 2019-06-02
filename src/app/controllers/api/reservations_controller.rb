class Api::ReservationsController < Api::ApiController
  include Concerns::TokenAuthenticable

  # TODO: customerが非会員かどうかに応じて、認証処理を追加する
  skip_before_action :authenticate_api_customer!, only: :create

  def create
    reservation = Reservation.new(reservation_params)
    reservation.build_shifts

    Reservation.transaction do
      reservation.save!
      ReservationMailer.confirm_reservation(reservation).deliver_now
    end
  end

  def index
    reservations = current_api_customer
      .reservations
      .paginate(index_params[:page])
      .order_reserved_at

    # total_pages > data の順にキーを配置しなければ、エラーになる可能性あり
    render json: { 
      total_pages: reservations.total_pages,
      data: reservations.to_resources,
    }
  end

  def show
    render json: { 
      data: Reservation.find(params[:id]).to_resource,
    }
  end

  def destroy
    Reservation.find(params[:id]).cancel
    ReservationMailer.cancel_reservation(self).deliver_now

    render json: { data: 'ok' }
  end

  private
  def index_params
    params.permit(:page)
  end

  def reservation_params
    params.permit(
      :customer_id,
      :store_id,
      :children_count,
      :reservation_comment,
      :reservation_date,
      :start_time,
      :is_first,
      coupon_ids: [],
      reservation_details_attributes: [
        :menu_id, 
        :mimitsubo_count,
        option_ids: [],
      ]
    )
  end
end
