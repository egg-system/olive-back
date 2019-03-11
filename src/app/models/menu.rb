class Menu < ApplicationRecord
    belongs_to :store
    belongs_to :menu_category
end
