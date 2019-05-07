class Option < ApplicationRecord
  belongs_to :skill
  belongs_to :department

  attr_accessor :is_option, :is_mimitsubo_jewelry

  def is_acupuncture
    self.id === ACUPUNCTURE_OPTION_ID
  end

  def is_mimitsubo_jewelry
    self.id === MIMITSUBO_JWELRY_OPTION_ID
  end

  def to_api_json
    return {
      id: self.id,
      name: self.name,
      description: self.description,
      price: self.fee,
      is_mimitsubo_jewelry: self.is_mimitsubo_jewelry,
    }
  end

  def self.mimitsubo_jewelry_fee
    self.find(MIMITSUBO_JWELRY_OPTION_ID).fee
  end
  
  scope :where_not_mimitsubo_jewelry, -> {
    where.not('options.id = ?', MIMITSUBO_JWELRY_OPTION_ID)
  }

  private

  ACUPUNCTURE_OPTION_ID = 5
  MIMITSUBO_JWELRY_OPTION_ID = 7

end
