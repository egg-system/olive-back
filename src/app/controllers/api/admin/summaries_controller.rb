module ::Api
  module Admin
    class SummariesController < ::ApplicationController
      def index
        start_date = Date.parse(search_params[:start_date])
        end_date = Date.parse(search_params[:end_date])

        shifts = Shift
          .where(store_id: search_params[:store_id])
          .where(date: start_date..end_date)

        # 1時間ごとのシフト件数、予約件数を取りたいが、30分単位でシフトが管理されているため半分にする
        shift_count = (shifts.count / 2).ceil
        reserve_count = (shifts.joins(:reservation).count / 2).ceil
        reserve_ratio = ratio(reserve_count, shift_count)

        end_date = Date.today if end_date > Date.today
        shifts_today = Shift
          .where(store_id: search_params[:store_id])
          .where(date: start_date..end_date)

        shift_count_today = (shifts_today.count / 2).ceil
        reserve_count_today = (shifts_today.joins(:reservation).count / 2).ceil
        reserve_ratio_today = ratio(reserve_count_today, shift_count_today)

        summaries_json = {
          shiftCount: shift_count,
          reserveCount: reserve_count,
          reserveRatio: reserve_ratio,
          shiftCountToday: shift_count_today,
          reserveCountToday: reserve_count_today,
          reserveRatioToday: reserve_ratio_today
        }

        render json: summaries_json
      end

      protected

      def search_params
        return params.permit(:store_id, :start_date, :end_date)
      end

      def ratio(numerator, denominator)
        if denominator.zero?
          0.0
        else
          numerator / denominator.to_f
        end
      end
    end
  end
end
