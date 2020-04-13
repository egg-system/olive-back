class TreatGoal < ApplicationRecord
  has_many :medical_records_treat_goals
  has_many :medical_records, through: :medical_records_treat_goals
end
