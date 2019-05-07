class ReservationDetail < ApplicationRecord
    belongs_to :reservation
    belongs_to :menu
    belongs_to :store

    has_many :reservation_detail_options
    has_many :options, through: :reservation_detail_options
    accepts_nested_attributes_for :reservation_detail_options, allow_destroy: true

    validates :menu_id, presence: true

    def total_fee
        menus_fee = self.menu.fee
        options_fee_other_than_mimitsubo_jewelry = self.options.where_not_mimitsubo_jewelry.sum(:fee)
        options_fee_mimitsubo_jewelry = self.mimitsubo_count * Option.mimitsubo_jewelry_fee
        return menus_fee + options_fee_other_than_mimitsubo_jewelry + options_fee_mimitsubo_jewelry
    end

    def has_options
        return 0 < self.options.count
    end
end
