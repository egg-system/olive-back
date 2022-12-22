class ReservationDetail < ApplicationRecord
  belongs_to :reservation
  belongs_to :menu

  has_many :reservation_detail_options
  has_many :options, through: :reservation_detail_options
  accepts_nested_attributes_for :reservation_detail_options, allow_destroy: true

  validates :menu_id, presence: true

  def total_fee
    total_option_fee = self.options.sum { |option| option.fee }

    return self.menu.fee + total_option_fee
  end

  def has_options
    return self.options.present?
  end

  def option_names
    return self.options.map { |option| option.name }
  end

  def to_resource
    return {
      id: self.id,
      menu: self.menu,
      option_names: self.option_names
    }
  end
end
