class MedicalRecordsTreatGoal < ApplicationRecord
  belongs_to :treat_goal
  belongs_to :medical_record
end
