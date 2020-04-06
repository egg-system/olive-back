class Menu < ApplicationRecord
  belongs_to :menu_category
  belongs_to :skill
  
  has_many :store_menus, inverse_of: :store
  has_many :stores, through: :store_menus
  has_many :observations

  def is_acupuncture
    self.menu_category_id === MenuCategory::ACUPUNTURE_CATEGORY_ID
  end
  
  def to_sub_menu_attributes(options)
    if self.is_acupuncture
      options = options.reject{ |option| 
        option.is_acupuncture 
      }
    end

    return {
      id: self.id,
      name: self.name,
      price: self.fee, 
      minutes: self.service_minutes,
      description: self.description,
      department_id: self.menu_category.department_id, 
      options: options.map { |option| option.to_api_json },
    }
  end
end
