# frozen_string_literal: true

class Option < ApplicationRecord
  belongs_to :skill
  belongs_to :department

  has_many :reservation_detail_options
  has_many :reservation_details, through: :reservation_detail_options
  has_many :reservations, through: :reservation_details

  has_many :store_options, inverse_of: :store
  has_many :store, through: :store_options

  attr_accessor :is_option, :is_mimitsubo_jewelry

  def is_acupuncture
    id === ACUPUNCTURE_OPTION_ID
  end

  def is_mimitsubo_jewelry
    id === MIMITSUBO_JWELRY_OPTION_ID
  end

  def to_api_json
    {
      id: id,
      name: name,
      description: description,
      price: fee,
      is_mimitsubo_jewelry: is_mimitsubo_jewelry
    }
  end

  private

  ACUPUNCTURE_OPTION_ID = 5
  MIMITSUBO_JWELRY_OPTION_ID = 7
end
