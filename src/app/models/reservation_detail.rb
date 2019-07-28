# frozen_string_literal: true

class ReservationDetail < ApplicationRecord
  belongs_to :reservation
  belongs_to :menu

  has_many :reservation_detail_options
  has_many :options, through: :reservation_detail_options
  accepts_nested_attributes_for :reservation_detail_options, allow_destroy: true

  validates :menu_id, presence: true
  validate :validate_mimitsubo_option

  def total_fee
    total_option_fee = options.sum do |option|
      total_fee = option.fee

      # 耳つぼジュエリの場合、個数とかけた金額にする
      if mimitsubo_count.present? && option.is_mimitsubo_jewelry
        total_fee = option.fee * mimitsubo_count
      end

      total_fee
    end

    menu.fee + total_option_fee
  end

  def has_options
    options.present?
  end

  def option_names
    options.map do |option|
      option_name = option.name

      # 耳つぼジュエリの個数を表記するための実装
      if option.is_mimitsubo_jewelry
        option_name = "#{option.name} × #{mimitsubo_count}個"
      end

      option_name
    end
  end

  def to_resource
    {
      id: id,
      menu: menu,
      option_names: option_names
    }
  end

  MIMITSUBO_JEWELRY_OPTIONS = [2, 4, 6, 8, 10].freeze

  def validate_mimitsubo_option
    selected_mimitsubo_option = option_ids.include?(Option::MIMITSUBO_JWELRY_OPTION_ID)
    selected_mimitsubo_count = mimitsubo_count.present? && mimitsubo_count > 0

    unless selected_mimitsubo_option === selected_mimitsubo_count
      errors.add(:mimitsubo_count, 'は、耳つぼジュエリーのオプションが選択されている場合、入力必須になります。')
    end
  end
end
