class ReservationDetail < ApplicationRecord
    belongs_to :reservation
    belongs_to :menu
    
    has_many :reservation_detail_options
    has_many :options, through: :reservation_detail_options
    accepts_nested_attributes_for :reservation_detail_options, allow_destroy: true

    validates :menu_id, presence: true
end
