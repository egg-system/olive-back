class ReservationMailer < ApplicationMailer
  def confirm_reservation(reservation)
    @reservation = reservation
    @customer = reservation.customer
    mail(subject: '予約確定', to: @customer.email) do |format|
      format.text
    end
  end

  def cancel_reservation(reservation)
    @reservation = reservation
    @customer = reservation.customer
    mail(subject: '予約キャンセル', to: @customer.email) do |format|
      format.text
    end
  end

  def remind_reservation(reservation)
    @reservation = reservation
    @customer = reservation.customer
    @store = @reservation.store
    mail(subject: "ご予約日が近づいて参りました。 | #{@store.name}", to: @customer.email) do |format|
      format.text
    end
  end
end
