class Store < ApplicationRecord
  enum store_type: { owned: 0, franchised: 1 }

  has_many :store_menu
  has_many :menus, through: :store_menu

  has_many :store_option
  has_many :options, through: :store_option

  scope :viewable?, -> (current_store) {
    # 直営店は全直営店を閲覧可能
    return where(store_type: 0) if current_store.owned?
    return where(id: current_store.id) if current_store.franchised?
  }

  def owned?
    return self.store_type.to_sym === :owned
  end

  def franchised?
    return self.store_type.to_sym === :franchised
  end

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
    return { 
      id: self.id, 
      name: self.name, 
      menus: self.menus.map { |menu| menu.to_sub_menu_attributes(self.options) }
    }
  end
end
