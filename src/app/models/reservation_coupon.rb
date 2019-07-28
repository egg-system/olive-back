# frozen_string_literal: true

class ReservationCoupon < ApplicationRecord
  belongs_to :reservation
  belongs_to :coupon
end
