# frozen_string_literal: true

class Reservation < ApplicationRecord
  # 時間帯とキャンセルに関わる部分のみ、変更履歴を保持する
  audited only: %i[reservation_date start_time end_time canceled_at]
  require 'tod'

  # time型を扱いやすくするための実装
  serialize :start_time, Tod::TimeOfDay
  serialize :end_time, Tod::TimeOfDay

  extend DateModule
  include PaginationModule

  # shift周りの処理の切り出しmodule
  include ShiftBuildModule

  # 変更履歴周りの処理の切り出しmodule
  include ReservationAuditModule

  belongs_to :customer
  belongs_to :staff, optional: true
  belongs_to :store

  has_many :reservation_details
  accepts_nested_attributes_for :reservation_details
  validates :reservation_details, presence: true

  has_many :reservation_coupons
  has_many :coupons, through: :reservation_coupons
  accepts_nested_attributes_for :reservation_coupons, allow_destroy: true

  validate :validate_reservation_date, on: :create

  scope :where_customer_name, lambda { |customer_name|
    where('concat(last_name, first_name) like ?', "%#{customer_name}%")
  }

  scope :order_reserved_at, lambda {
    order(reservation_date: :desc)
      .order(start_time: :desc)
      .order(created_at: :desc)
  }

  scope :where_reserved_date, lambda { |date|
    where(reservation_date: date, canceled_at: nil)
  }

  def self.to_resources
    all.map(&:to_resource)
  end

  def to_resource
    {
      id: id,
      state: state,
      store: store,
      start_at: start_time.on(reservation_date),
      end_at: end_time.on(reservation_date),
      details: reservation_details.map(&:to_resource),
      coupons: coupons,
      fee: total_fee
    }
  end

  def reserved_at
    start_time.on(reservation_date)
  end

  def total_fee
    total_fee = reservation_details.sum(&:total_fee)
    total_fee -= coupons.length * 6000 if coupons.present?
    total_fee
  end

  def state
    return 'キャンセル済み' if canceled?

    reservation_end_at = end_time.on(reservation_date)
    visited = reservation_end_at < DateTime.now
    visited ? '来店済み' : '予約中'
  end

  def cancel
    # 予約枠取得時に影響しないよう、リレーションを削除する
    transaction do
      update(canceled_at: DateTime.now)
      reservation_shifts.delete_all
    end
  end

  def canceled?
    canceled_at.present?
  end

  def assigned?
    # シフトへの紐付けが存在する or キャンセル済みかどうかで判定
    persisted? && shifts.present? || canceled?
  end

  private

  def validate_reservation_date
    if reserved_at < Time.current
      errors.add(:reservation_date, '：過去の日時は使えません')
      errors.add(:start_time, '：過去の日時は使えません')
    end
  end
end
