module Api
  module Admin
    class StaffsController < ApplicationController
      def index
        store_id = staff_params[:store_id]
        date = staff_params[:reservation_date]
        start_time = staff_params[:reseravtion_start_time]

        assignable_staff_ids = Shift
          .where_not_reserved
          .where(store_id: store_id)
          .where(date: date)
          .where(start_at: start_time)
          .select(:staff_id)
          .distinct
          .pluck(:staff_id)

        menu_ids = staff_params[:reservation_menu_ids]
        option_ids = staff_params[:reservation_option_ids]

        staffs = Staff
          .where(id: assignable_staff_ids)
          .exclude_hidden
          .can_treats(menu_ids, option_ids)

        render json: staffs
      end

      # shiftのあるスタッフを検索する
      def staff_params
        return params.permit(
          :store_id,
          :reservation_date,
          :reseravtion_start_time,
          reservation_menu_ids: [],
          reservation_option_ids: []
        )
      end
    end
  end
end
