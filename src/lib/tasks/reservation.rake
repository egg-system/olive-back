namespace :reservation do
  desc '予約のリマインドメールを送信する'
  task :send_remind_mail => :environment do
    reservations = Reservation.where_reserved_date(Date.today.tomorrow)
    reservations.each { |resrvation| 
      ReservationMailer.remind_reservation(resrvation).deliver_now
    }
  end
end
