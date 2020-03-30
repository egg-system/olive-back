class CurrentHospital < ApplicationRecord
  has_many :medical_records_current_hospitals
  has_many :medical_records, through: :medical_records_current_hospitals
end
