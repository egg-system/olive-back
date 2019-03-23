class Reservation < ApplicationRecord
    belongs_to :pregnant_status
    belongs_to :with_child_status
    belongs_to :staff

    scope :join_staff, ->{
        left_joins(:staff).select("reservations.*").select("concat(staffs.last_name, staffs.first_name) as staff_name")
    }
end
