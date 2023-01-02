class OptionMenuCategory < ApplicationRecord
  belongs_to :option
  belongs_to :menu_category
end
