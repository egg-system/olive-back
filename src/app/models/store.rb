class Store < ApplicationRecord
  enum store_type: { owned: 0, franchised: 1 }

  has_many :store_menu
  has_many :menus, through: :store_menu

  def to_shop
    shop_attributes
  end

  def to_shop_menus
    shop_menus = [ sub_shop_attributes ]
    
    if is_head
      este_store = Store.find(Settings.stores.head_este_store_id)
      shop_menus.concat(este_store.to_shop_menus)
    end

    return shop_menus
  end

  private
  
  SHOP_KEYS = [ :id, :name, :open_at, :close_at, :break_from, :break_to ]
  def shop_attributes
    SHOP_KEYS.map { |json_key|
      [json_key, attributes[json_key.to_s]]
    }.to_h.to_json
  end

  def is_head
    self.id === Settings.stores.head_store_id
  end

  def sub_shop_attributes
    menus = self.menus.to_sub_menus
    return { 
      id: self.id, 
      name: self.name, 
      menus: menus 
    }
  end
end
