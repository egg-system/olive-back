class ReservationShift < ApplicationRecord
  belongs_to :reservation, -> { where reservations: { canceled_at: nil } }
  belongs_to :shift
end
