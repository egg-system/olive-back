class Store < ApplicationRecord
  enum store_type: { owned: 0, franchised_sapporo_kokubun: 1, franchised_tokyo_test: 2 }

  # time型を扱いやすくするための実装
  attribute :open_at, :time_only
  attribute :close_at, :time_only
  attribute :break_from, :time_only
  attribute :break_to, :time_only

  validates_presence_of :break_from, if: :input_break_time?
  validates_presence_of :break_to, if: :input_break_time?

  has_many :store_menu, dependent: :destroy
  has_many :menus, through: :store_menu

  has_many :store_option, dependent: :destroy
  has_many :options, through: :store_option

  has_many :store_staffs, dependent: :destroy
  has_many :staffs, through: :store_staffs

  has_many :visit_stores
  has_many :visit_customers,
    through: :visit_stores,
    class_name: 'Customer',
    foreign_key: 'customer_id'
  has_many :near_store_options
  has_many :near_stores, through: :near_store_options

  scope :viewable?, ->(current_store) {
    # 直営店は全直営店を閲覧可能
    return where(store_type: 0) if current_store.owned?
    return where(id: current_store.id) if current_store.franchised?
  }

  def owned?
    return self.store_type.to_sym === :owned
  end

  def franchised?
    return !self.owned?
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

  def slot_time_labels
    return self.select_slot_times(Shift.display_slot_times).keys
  end

  def get_time_slots(date)
    return self.select_slot_times(Shift.slot_times).map { |label, time_slot|
      day = Date.parse(date)
      Tod::TimeOfDay.parse(time_slot).on(day)
    }
  end

  def save_near_stores(near_store_ids)
    near_store_ids = [] if near_store_ids.blank?

    current_near_store_ids = near_store_options.pluck(:near_store_id)

    delete_near_store_ids = current_near_store_ids - near_store_ids
    create_near_store_ids = near_store_ids - current_near_store_ids
    near_store_options.where(near_store_id: delete_near_store_ids).destroy_all if delete_near_store_ids.present?
    create_near_store_ids.each { |near_store_id|
      near_store_options.create(near_store_id: near_store_id)
    }
  end

  protected

  def select_slot_times(slot_times)
    return slot_times.select { |label, slot_time|
      slotted_at = Tod::TimeOfDay(slot_time)

      # 開店時間内か
      is_opening_store = self.open_at <= slotted_at && slotted_at < self.close_at
      next is_opening_store unless input_break_time?

      # 休憩時間外か
      next slotted_at < self.break_from || self.break_to <= slotted_at
    }
  end

  private

  SHOP_KEYS = [:id, :name, :open_at, :close_at, :break_from, :break_to]

  def shop_attributes
    SHOP_KEYS.map { |json_key|
      [json_key, attributes[json_key.to_s].to_s]
    }.to_h
    .merge({
     near_stores: self.near_stores.map do |near_store|
       { near_store_id: near_store.id, short_name: near_store.short_name }
     end
   }).to_json
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
