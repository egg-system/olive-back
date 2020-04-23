class Store < ApplicationRecord
  enum store_type: { owned: 0, franchised: 1 }

  # time型を扱いやすくするための実装
  serialize :open_at, Tod::TimeOfDay
  serialize :close_at, Tod::TimeOfDay
  serialize :break_from, Tod::TimeOfDay
  serialize :break_to, Tod::TimeOfDay

  validates_presence_of :break_from, if: :input_break_time?
  validates_presence_of :break_to, if: :input_break_time?
  
  has_many :store_menu
  has_many :menus, through: :store_menu

  has_many :store_option
  has_many :options, through: :store_option

  scope :viewable?, ->(current_store) {
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
    shop_menus = [sub_shop_attributes]

    if is_head
      este_store = Store.find(Settings.stores.head_este_store_id)
      shop_menus.concat(este_store.to_shop_menus)
    end

    return shop_menus
  end

  def reserve_url
    return "#{super}/menus/?shopId=#{self.id}"
  end

  def store_type_label
    store_type_key = self.store_type.to_sym.to_s
    return Settings.store_type.to_h.invert[store_type_key]
  end

  def slot_times
    return Shift.slot_times.select { |label, slot_time|
      slotted_at = Tod::TimeOfDay(slot_time)
      
      # 開店時間内か
      is_opening_store = self.open_at <= slotted_at && slotted_at < self.close_at
      next is_opening_store unless input_break_time?

      # 休憩時間外か
      next slotted_at < self.break_from || self.break_to <= slotted_at
    }
  end

  def slot_time_labels
    return self.slot_times.keys
  end

  def get_time_slots(date)
    return self.slot_times.map { |label, time_slot|
      day = Date.parse(date)
      Tod::TimeOfDay.parse(time_slot).on(day)
    }
  end

  private

  SHOP_KEYS = [:id, :name, :open_at, :close_at, :break_from, :break_to]

  def shop_attributes
    SHOP_KEYS.map { |json_key|
      [json_key, attributes[json_key.to_s].to_s]
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

  def input_break_time?
    return self.break_from.present? || self.break_to.present?
  end
end
