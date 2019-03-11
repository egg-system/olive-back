class Skill < ApplicationRecord
    has_many :staffs, through: :staffs_skill
end
