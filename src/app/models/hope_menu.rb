class HopeMenu < ApplicationRecord
  has_many :medical_records_hope_menus
  has_many :medical_records, through: :medical_records_hope_menus
end
