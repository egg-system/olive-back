class GoalTherapy < ApplicationRecord
  belongs_to :goal_therapy_menu, optional: true
end
