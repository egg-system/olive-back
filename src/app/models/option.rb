class Option < ApplicationRecord
  belongs_to :skill
  belongs_to :department

  has_many :reservation_detail_options
  has_many :reservation_details, through: :reservation_detail_options
  has_many :reservations, through: :reservation_details

  has_many :store_options, inverse_of: :store
  has_many :store, through: :store_options
  has_many :option_menu_categories, dependent: :destroy
  has_many :menu_categories, through: :option_menu_categories
  accepts_nested_attributes_for :menu_categories, allow_destroy: true

  validates :menu_category_ids, presence: true
  validates :name, presence: true

  def to_api_json
    return {
      id: self.id,
      name: self.name,
      description: self.description,
      price: self.fee,
      menu_category_ids: self.menu_categories.pluck(:id)
    }
  end
end
