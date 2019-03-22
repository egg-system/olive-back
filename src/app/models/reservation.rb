class Reservation < ApplicationRecord
    belongs_to :pregnant_status
    belongs_to :with_child_status

    scope :join_staff, ->{
        left_joins(:staff).select("reservations.*, staffs.name as staff_name")
    }
end
