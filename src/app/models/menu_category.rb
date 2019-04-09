class MenuCategory < ApplicationRecord
    belongs_to :department

    ACUPUNTURE_CATEGORY_ID = 2
    OPTION_CATEGORY_ID = 7
end
