class Menu < ApplicationRecord
  belongs_to :menu_category
  belongs_to :skill

  has_many :store_menus, inverse_of: :store
  has_many :stores, through: :store_menus
  has_many :observations

  # DBのdefault値を無視するために追加
  attribute :skill_id, :integer, default: nil

  validates :menu_category, presence: true

  def to_sub_menu_attributes(options)
    options = options.filter { |option|
      option.menu_categories.pluck(:id).include?(self.menu_category_id)
    }

    return {
      id: self.id,
      name: self.name,
      price: self.fee,
      minutes: self.service_minutes,
      description: self.description,
      department_id: self.menu_category.department_id,
      menu_category_id: self.menu_category_id,
      options: options.map { |option| option.to_api_json },
    }
  end
end
