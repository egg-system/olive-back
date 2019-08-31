class DashboardsController < ApplicationController
  def index
    viewable_store_ids = current_staff.stores.pluck(:id)
    @reservations = Reservation.where(reservation_date: Date.today)
      .where(store_id: viewable_store_ids)
      .order_reserved_at(:asc)
  end
end
