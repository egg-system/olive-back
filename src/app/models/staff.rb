class Staff < ApplicationRecord
    has_many :skill, through: :staffs_skill 
    belongs_to :store
    has_many :shift
    has_one :user
end