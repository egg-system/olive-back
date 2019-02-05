class Staff < ApplicationRecord
    belongs_to :staffs_skill
    belongs_to :store
    belongs_to :role
    has_many :shift
end
