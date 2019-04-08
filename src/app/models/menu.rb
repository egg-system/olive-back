class Menu < ApplicationRecord
    belongs_to :menu_category
    has_many :skills, through: :skill_menus
    has_many :stores, through: :store_menus

    ACUPUNTURE_WITH_MASSAGE = 11
    ACUPUNTURE_WITHOUT_MASSAGE = 12
    ACUPUNTURE_OPTION_MENU_IDS = [
        ACUPUNTURE_WITH_MASSAGE, 
        ACUPUNTURE_WITHOUT_MASSAGE
    ]

    attr_accessor :is_option

    def is_option
        self.menu_category_id === MenuCategory::OPTION_CATEGORY_ID
    end

    def is_acupuncture
        self.menu_category_id === MenuCategory::ACUPUNTURE_CATEGORY_ID
    end

    def is_option_acupuncture
        ACUPUNTURE_OPTION_MENU_IDS.include?(self.id)
    end

    def self.to_sub_menus
        all_menus = self.all
        options = all_menus.select { |menu| menu.is_option }
        menus = all_menus - options

        return menus.map { |menu|
            sub_options = options
            if menu.is_acupuncture
                sub_options = sub_options.reject{ |option| 
                    option.is_option_acupuncture 
                }
            end
            
            json = menu.to_sub_menu_attributes
            json[:options] = sub_options
            
            json
        }
    end
    
    def to_sub_menu_attributes()
        return {
            id: self.id, 
            name: self.name,
            price: self.fee, 
            minutes: self.service_minutes,
            description: self.description,
        }
    end
end
