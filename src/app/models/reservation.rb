class Reservation < ApplicationRecord
    acts_as_paranoid

    belongs_to :pregnant_state
end
