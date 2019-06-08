class DashboardsController < ApplicationController
  def index
    @reservations = Reservation.where(reservation_date: Date.today)
  end
end
