class ReservationOption < ApplicationRecord
    belongs_to :reservation
    belongs_to :option
end
