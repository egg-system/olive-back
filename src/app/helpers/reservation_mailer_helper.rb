module ReservationMailerHelper
    def store_template_of_confirm(store)
        render "reservation_mailer/store_template/confirm/#{Settings.store_template_names[store.id - 1]}"
    end

    def store_template_of_remind(store)
        render "reservation_mailer/store_template/remind/#{Settings.store_template_names[store.id - 1]}"
    end
end