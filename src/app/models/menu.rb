class Menu < ApplicationRecord
    belongs_to :menu_category

    has_many :skill_menus
    has_many :skills, through: :skill_menus
    
    has_many :store_menus
    has_many :stores, through: :store_menus

    def self.to_sub_menus
        @@all_options = Option.all
        
        return self.all.map { |menu|
            menu.to_sub_menu_attributes
        }
    end

    def is_acupuncture
        self.menu_category_id === MenuCategory::ACUPUNTURE_CATEGORY_ID
    end
    
    def to_sub_menu_attributes()
        options = @@all_options
        
        if options.nil?
            options = Option.all
        end

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
            options: options.map { |option| option.to_api_json },
        }
    end
end
