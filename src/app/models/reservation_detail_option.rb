class ReservationDetailOption < ApplicationRecord
  belongs_to :reservation_detail
  belongs_to :option
end
