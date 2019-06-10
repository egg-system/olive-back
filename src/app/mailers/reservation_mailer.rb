class ReservationMailer < ApplicationMailer
  def confirm_reservation(reservation)
    @reservation = reservation
    @customer = reservation.customer
    @store = @reservation.store
    mail(subject: 'ご予約の確定メール', to: @customer.email) do |format|
      format.text
    end
  end

  def cancel_reservation(reservation)
    logger.debug(reservation)
    @reservation = reservation
    @customer = reservation.customer
    @store = @reservation.store
    mail(subject: 'ご予約のキャンセル', to: @customer.email) do |format|
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
