class Reservation < ApplicationRecord
    acts_as_paranoid

    belongs_to :pregnant_status
    belongs_to :with_child_status
    belongs_to :staff
end
