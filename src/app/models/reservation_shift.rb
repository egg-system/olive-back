class ReservationShift < ApplicationRecord
  belongs_to :reservation
  belongs_to :shift

  validates :shift_id, uniqueness: true
end
