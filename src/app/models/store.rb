class Store < ApplicationRecord
  enum store_type: { owned: 0, franchised: 1 }

  def to_shop
    shop_attributes
  end

  private
  
  SHOP_KEYS = [ :id, :name, :open_at, :close_at, :break_from, :break_to ]
  def shop_attributes
    SHOP_KEYS.map { |json_key|
      [json_key, attributes[json_key.to_s]]
    }.to_h.to_json
  end
end
