module Concerns::ReservationSearchable
  extend ActiveSupport::Concern

  def search_reservations
    reservations = Reservation.joins(:customer).paginate(params[:page], 20)
    reservations = reservations.order_reserved_at if @order === 'reserved_at'
    reservations = reservations.order('id DESC')

    reservations = reservations.like_customer_name(@customer_name)
    reservations = reservations.like_customer_tel(@customer_tel)
    
    reservations = reservations.where('reservation_date >= ?', @from_date) if @from_date.present?
    reservations = reservations.where('reservation_date <= ?', @to_date) if @to_date.present?

    if @store_id.present?
      reservations = reservations.where(store_id: @store_id)
    else # 検索する値がなくても、権限に応じて絞り込む
      store_ids = @stores.pluck(:id)
      reservations = reservations.where(store_id: store_ids)
    end

    reservations = reservations.where_state(@state) if @state.present?

    unless @staff_id.nil?
      reservations = reservations.where(staff_id: @staff_id) if @staff_id.to_i > 0
      reservations = reservations.where(staff_id: nil) if @staff_id === 'none'
      reservations = reservations.where.not(staff_id: nil) if @staff_id === 'any'
    end

    return reservations
  end

  # 必要であれば、使い回し可能にする
  def parse_date_params(param_name)
    return nil if params["#{param_name}(1i)"].empty?
    return nil if params["#{param_name}(2i)"].empty?
    return nil if params["#{param_name}(3i)"].empty?

    return Date.new(
      params["#{param_name}(1i)"].to_i,
      params["#{param_name}(2i)"].to_i,
      params["#{param_name}(3i)"].to_i
    )
  end
end