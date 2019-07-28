# frozen_string_literal: true

class Store < ApplicationRecord
  enum store_type: { owned: 0, franchised: 1 }

  has_many :store_menu
  has_many :menus, through: :store_menu

  has_many :store_option
  has_many :options, through: :store_option

  def to_shop
    shop_attributes
  end

  def to_shop_menus
    shop_menus = [sub_shop_attributes]

    if is_head
      este_store = Store.find(Settings.stores.head_este_store_id)
      shop_menus.concat(este_store.to_shop_menus)
    end

    shop_menus
  end

  private

  SHOP_KEYS = %i[id name open_at close_at break_from break_to].freeze
  def shop_attributes
    SHOP_KEYS.map do |json_key|
      [json_key, attributes[json_key.to_s]]
    end.to_h.to_json
  end

  def is_head
    id === Settings.stores.head_store_id
  end

  def sub_shop_attributes
    {
      id: id,
      name: name,
      menus: menus.map { |menu| menu.to_sub_menu_attributes(options) }
    }
  end
end
