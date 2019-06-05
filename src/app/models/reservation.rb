class Reservation < ApplicationRecord
  require 'tod'

  # time型を扱いやすくするための実装
  serialize :start_time, Tod::TimeOfDay
  serialize :end_time, Tod::TimeOfDay

  extend DateModule
  include PaginationModule

  belongs_to :customer
  belongs_to :staff, optional: true
  belongs_to :store

  has_many :reservation_details
  accepts_nested_attributes_for :reservation_details
  validates_presence_of :reservation_details

  has_many :reservation_coupons
  has_many :coupons, through: :reservation_coupons
  accepts_nested_attributes_for :reservation_coupons, allow_destroy: true

  has_many :reservation_shifts, dependent: :delete_all
  has_many :shifts, through: :reservation_shifts

  scope :where_customer_name, -> (customer_name) {
    where("concat(last_name, first_name) like ?", "%#{params[:customer_name]}%")  
  }

  scope :order_reserved_at, -> {	
    order(reservation_date: :desc)
      .order(start_time: :desc)
      .order(created_at: :desc)
  }

  scope :where_reserved_date, -> (date) {
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
      menus: reservation_details.map { |detail| detail.menu },
      fee: self.total_fee,
    }
  end

  def build_shifts
    self.end_time = extract_end_time_from_details
    treatable_shifts = Shift
      .where(date: self.reservation_date)
      .where(start_at: (self.start_time.to_s)...(self.end_time.to_s))
      .where(staff_id: extract_can_treat_staff_ids)
      .where(store_id: self.store_id)
      .where_not_reserved

    shifts = treatable_shifts.group_by { |shift| shift.staff.id }
      .select { |staff_id, shifts| shifts.length === necessary_shift_count }
      .values
      .min_by { |shifts| shifts.first.staff.skill_staffs.length }

    return if shifts.nil?

    self.shifts = shifts
    self.staff = shifts.first.staff
  end

  def reserved_at
    self.start_time.on(self.reservation_date)
  end

  def total_fee
    return self.reservation_details.sum { |detail| detail.total_fee }
  end

  def necessary_shift_count
    reserved_duration = Tod::Shift.new(self.start_time, self.end_time).duration
    return reserved_duration / Shift::SLOT_INCREMENT_MITUNES.minutes.seconds
  end

  def state
    return 'キャンセル済み' if self.canceled?

    reservation_end_at = self.end_time.on(self.reservation_date)
    visited = reservation_end_at < DateTime.now
    return visited ? '来店済み' : '予約中'
  end

  def cancel
    # 予約枠取得時に影響しないよう、リレーションを削除する
    self.transaction do
      self.update(canceled_at: DateTime.now)
      self.reservation_shifts.delete_all
    end
  end

  def canceled?
    return self.canceled_at.present?
  end

  private

  def extract_can_treat_staff_ids
    menu_ids = self.reservation_details.map { |detail| detail.menu.id }
    option_ids = self.reservation_details.flat_map { |detail|
      detail.options.map { |option| option.id }
    }
    return Staff.can_treats(menu_ids, option_ids).map { |staff| staff.id }
  end

  def extract_end_time_from_details
    reservation_minutes = self.reservation_details.sum { |detail| detail.menu.service_minutes }
    return self.start_time + reservation_minutes.minutes unless self.start_time.nil?
  end
end
