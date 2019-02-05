class ReservationDetail < ApplicationRecord
    belongs_to :user_reservation
    belongs_to :menu
end
