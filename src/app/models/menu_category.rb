class MenuCategory < ApplicationRecord
  belongs_to :department

  ACUPUNTURE_CATEGORY_ID = 2
    
  scope :join_department, ->{
    left_joins(:department).select("departments.name as department_name")
  }

  scope :join_tables, ->{
    select('menu_categories.*').join_department
  }
end
