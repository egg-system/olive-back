class DashboardsController < ApplicationController
  def index
    @viewable_stores = current_staff.stores.eager_load(:staffs)
    @reservations = Reservation.where(reservation_date: Date.today)
      .where(store_id: viewable_stores.pluck(:id))
      .order_reserved_at(:asc)
  end
end
