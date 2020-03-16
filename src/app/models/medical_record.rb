class MedicalRecord < ApplicationRecord
  belongs_to :customer
  belongs_to :hope_therapy, optional: true
  belongs_to :goal_therapy, optional: true
  belongs_to :many_posture, optional: true
  belongs_to :pregnancy, optional: true
  belongs_to :drinking, optional: true
  belongs_to :cigarette, optional: true
  belongs_to :massage, optional: true
  belongs_to :exercise, optional: true
end
