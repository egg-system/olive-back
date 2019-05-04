class ReservationDetailOption < ApplicationRecord
    belongs_to :reservation_detail
    belongs_to :option

    def name
        return self.option.name
    end

    def is_mimitsubo_jewelry
        return self.option.is_mimitsubo_jewelry
    end

    def mimitsubo_count
        return self.reservation_detail.mimitsubo_count
    end
end
