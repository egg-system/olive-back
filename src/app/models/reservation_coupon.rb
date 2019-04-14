class ReservationCoupon < ApplicationRecord
  belongs_to :reservation
  belongs_to :coupon
end
