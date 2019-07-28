# frozen_string_literal: true

class MenuCategory < ApplicationRecord
  belongs_to :department

  ACUPUNTURE_CATEGORY_ID = 2

  scope :join_department, lambda {
    left_joins(:department).select('departments.name as department_name')
  }

  scope :join_tables, lambda {
    select('menu_categories.*').join_department
  }
end
