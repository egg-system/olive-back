# frozen_string_literal: true

class Menu < ApplicationRecord
  belongs_to :menu_category
  belongs_to :skill

  has_many :store_menus, inverse_of: :store
  has_many :stores, through: :store_menus

  def is_acupuncture
    menu_category_id === MenuCategory::ACUPUNTURE_CATEGORY_ID
  end

  def to_sub_menu_attributes(options)
    options = options.reject(&:is_acupuncture) if is_acupuncture

    {
      id: id,
      name: name,
      price: fee,
      minutes: service_minutes,
      description: description,
      department_id: menu_category.department_id,
      options: options.map(&:to_api_json)
    }
  end
end
