module ::Api
  module Admin
    class ReservationsController < ::ApplicationController
      def index
        start_date = Date.parse(search_params[:start_date])
        end_date = Date.parse(search_params[:end_date])

        reservations = Reservation
          .where(store_id: search_params[:store_id])
          .where(reservation_date: start_date..end_date)
          .where(canceled_at: nil)
          .eager_load(:staff)
          .eager_load(:shifts)

        reservations_json = reservations.map do |reservation|
          staff = reservation.staff
          {
            id: reservation.id,
            date: reservation.reservation_date,
            startTime: reservation.start_time.to_s,
            endTime: reservation.end_time.to_s,
            customer: {
              id: reservation.customer.id,
              name: reservation.customer.full_name
            },
            staff: {
              id: staff.nil? ? nil : staff.id,
              name: staff.nil? ? '未割当' : staff.full_name
            },
            shiftIds: reservation.shifts.pluck(:id)
          }
        end

        render json: reservations_json
      end

      protected

      def search_params
        return params.permit(:store_id, :start_date, :end_date)
      end
    end
  end
end
