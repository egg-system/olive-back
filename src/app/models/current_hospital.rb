class CurrentHospital < ApplicationRecord
  belongs_to :current_hospital_menu, optional: true
end
