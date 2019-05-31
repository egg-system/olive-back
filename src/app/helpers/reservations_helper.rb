module ReservationsHelper
  def mimitsubo_jwery_options
    ReservationDetail::MIMITSUBO_JEWELRY_OPTIONS.map { |option| ["#{option}粒", option] }
  end
end
