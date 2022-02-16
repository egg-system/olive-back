class Reservation < ApplicationRecord
  # 時間帯とキャンセルに関わる部分のみ、変更履歴を保持する
  audited only: [:reservation_date, :start_time, :end_time, :canceled_at]

  # time型を扱いやすくするための実装
  attribute :start_time, :time_only
  attribute :end_time, :time_only

  extend DateModule
  include PaginationModule

  # shift周りの処理の切り出しmodule
  include ShiftBuildModule

  # 変更履歴周りの処理の切り出しmodule
  include ReservationAuditModule

  # 予約状況周りの処理の切り出しmodule
  include ReservationStateModule

  belongs_to :customer
  belongs_to :staff, optional: true
  belongs_to :store

  has_many :reservation_details
  accepts_nested_attributes_for :reservation_details
  validates_presence_of :reservation_details

  has_many :reservation_coupons
  has_many :coupons, through: :reservation_coupons
  accepts_nested_attributes_for :reservation_coupons, allow_destroy: true

  validate :validate_reservation_date, on: :create

  after_create :create_visit_stores

  scope :like_customer_name, ->(customer_name) {
    joins(:customer).merge(Customer.like_name(customer_name)) if customer_name.present?
  }

  scope :like_customer_kana_name, ->(customer_kana_name) {
    joins(:customer).merge(Customer.like_kana_name(customer_kana_name)) if customer_kana_name.present?
  }

  scope :like_customer_tel, ->(customer_tel) {
    joins(:customer).merge(Customer.like_tel(customer_tel)) if customer_tel.present?
  }

  scope :order_reserved_at, ->(order = :desc) {
    order(reservation_date: :desc)
      .order(start_time: :desc)
      .order(created_at: :desc)
  }

  scope :where_reserved_date, ->(date) {
    where(reservation_date: date, canceled_at: nil)
  }

  def self.to_resources
    return self.all.map { |reservation| reservation.to_resource }
  end

  def to_resource
    return {
      id: self.id,
      state: self.state,
      store: self.store,
      start_at: self.start_time.on(self.reservation_date),
      end_at: self.end_time.on(self.reservation_date),
      details: reservation_details.map { |detail| detail.to_resource },
      coupons: self.coupons,
      fee: self.total_fee,
    }
  end

  def reserved_at
    self.start_time.on(self.reservation_date)
  end

  def total_fee
    total_fee = self.reservation_details.sum { |detail| detail.total_fee }
    total_fee = total_fee - self.coupons.length * 6000 if self.coupons.present?
    return total_fee
  end

  def cancel
    # 予約枠取得時に影響しないよう、リレーションを削除する
    self.transaction do
      self.update!(canceled_at: DateTime.now)
      self.reservation_shifts.delete_all
    end
  end

  def canceled?
    return self.canceled_at.present?
  end

  def assigned?
    # シフトへの紐付けが存在する or キャンセル済みかどうかで判定
    return self.persisted? && self.shifts.present? || self.canceled?
  end

  def email_present?
    self.customer.email.present?
  end

  private

  def validate_reservation_date
    if self.reserved_at < Time.current
      errors.add(:reservation_date, "：過去の日時は使えません")
      errors.add(:start_time, "：過去の日時は使えません")
    end
  end

  def create_visit_stores
    return if self.customer.blank?

    store_ids = Store.where(store_type: Store.find(self.store_id).store_type).pluck(:id)
    (store_ids - self.customer.stores.pluck(:id)).each do |store_id|
      self.customer.visit_stores.build(store_id: store_id).save
    end
  end
end
