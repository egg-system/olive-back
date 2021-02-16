module Api
  module Admin
    class ShiftsController < ApplicationController
      def index
        start_date = Date.parse(search_params[:start_date])
        end_date = Date.parse(search_params[:end_date])

        shifts = Shift
          .where(store_id: search_params[:store_id])
          .where(date: start_date..end_date)
          .eager_load(:staff)
          .eager_load(:reservation)

        shifts_json = shifts.map do |shift|
          reservation_id = shift.reservation.nil? ? nil : shift.reservation.id
          {
            id: shift.id,
            date: shift.date,
            startTime: shift.start_at.to_s,
            endTime: shift.end_at.to_s,
            reservationId: reservation_id,
            staff: {
              id: shift.staff.id,
              name: shift.staff.full_name
            }
          }
        end

        render json: shifts_json
      end

      protected

      def search_params
        return params.permit(:store_id, :start_date, :end_date)
      end
    end
  end
end
