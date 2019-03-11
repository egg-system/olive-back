class Staff < ApplicationRecord
    belongs_to :staffs_skill
    belongs_to :store
    has_many :shift
    has_one :user
end
