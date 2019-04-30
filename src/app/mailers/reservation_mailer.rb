class ReservationMailer < ApplicationMailer
  def confirm_reservation(reservation)
    @reservation = reservation
    @customer = reservation.customer
    mail(subject: '予約確定', to: @customer.email) do |format|
      format.text
    end
  end
end
