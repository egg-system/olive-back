class Store < ApplicationRecord
  enum store_type: { owned: 0, franchised: 1 }

  def to_shop
    shop_attributes
  end

  private
  
  SHOP_KEYS = [ :id, :name, :open_at, :close_at, :break_from, :break_to ]
  def shop_attributes
    attributes.select { |key, value|
      SHOP_KEYS.include?(key.to_sym)
    }.to_json
  end
end
