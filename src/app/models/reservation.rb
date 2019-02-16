class Reservation < ApplicationRecord
    belongs_to :pregnant_status
    belongs_to :with_child_status
end
