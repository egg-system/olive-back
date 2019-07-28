# frozen_string_literal: true

class ReservationShift < ApplicationRecord
  belongs_to :reservation
  belongs_to :shift
end
