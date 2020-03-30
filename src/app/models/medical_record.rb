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

  has_many :medical_records_hope_menus
  has_many :hope_menus, through: :medical_records_hope_menus
  has_many :medical_records_treat_goals
  has_many :treat_goals, through: :medical_records_treat_goals
  has_many :medical_records_current_hospitals
  has_many :current_hospitals, through: :medical_records_current_hospitals
end
