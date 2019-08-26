class DashboardsController < ApplicationController
  def index
    @reservations = Reservation.where(reservation_date: Date.today)
      .where(store_id: viewable_stores.pluck(:id))
  end
end
