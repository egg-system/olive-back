class Menu < ApplicationRecord
    belongs_to :menu_category
    has_many :skills, through: :skill_menus
    has_many :stores, through: :store_menus
end
