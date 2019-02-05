class Menu < ApplicationRecord
    belongs_to :store
    belongs_to :tax
    belongs_to :menu_category
end
