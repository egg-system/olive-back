class MedicalRecordsCurrentHospital < ApplicationRecord
  belongs_to :current_hospital
  belongs_to :medical_record
end
