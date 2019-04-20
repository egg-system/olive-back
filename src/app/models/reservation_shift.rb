class ReservationShift < ApplicationRecord
  belongs_to :reservation
  belongs_to :shift
end
