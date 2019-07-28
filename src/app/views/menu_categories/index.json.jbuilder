# frozen_string_literal: true

json.array! @menu_categories, partial: 'menu_categories/menu_category', as: :menu_category
