# frozen_string_literal: true

class Shift < ApplicationRecord
  require 'tod'

  # time型を扱いやすくするための実装
  serialize :start_at, Tod::TimeOfDay
  serialize :end_at, Tod::TimeOfDay

  extend DateModule

  has_one :reservation_shift
  has_one :reservation, through: :reservation_shift

  belongs_to :store
  belongs_to :staff

  scope :where_months, lambda { |start_month, end_month = nil|
    start_date, end_date = get_month_range(start_month, end_month)
    where(date: start_date..end_date)
  }

  scope :where_not_reserved, lambda {
    left_joins(:reservation).where('reservations.id is NULL')
  }

  def self.to_time_slots
    date_shift_groups = all.group_by(&:date)
    date_shift_groups.map do |date, shifts|
      time_shift_groups = shifts.group_by(&:shift_at)
      time_slots = time_shift_groups.map do |shift_at, shift_group|
        {
          start_time: shift_at,
          staff_ids: shift_group.map(&:staff_id)
        }
      end

      [date.strftime('%Y%m%d'), time_slots]
    end.to_h
  end

  def self.import(csv_row)
    shift_date = "#{csv_row['年月']}-#{csv_row['日']}"
    store_id = csv_row['店舗ID']
    staff_id = csv_row['スタッフID']

    csv_row.select do |key, value|
      SHIFT_TIMES.key?(key) && value === '1'
    end.each do |key, _value|
      shift_time = Tod::TimeOfDay.parse(SHIFT_TIMES[key])
      shift = Shift.where(
        store_id: store_id,
        staff_id: staff_id,
        date: shift_date,
        start_at: shift_time,
        end_at: shift_time + SLOT_INCREMENT_MITUNES.minutes
      ).first_or_create
    end
  end

  def self.get_time_slots(date)
    SHIFT_TIMES.map do |_label, time_slot|
      day = Date.parse(date)
      Tod::TimeOfDay.parse(time_slot).on(day)
    end
  end

  def self.slot_time_labels
    SHIFT_TIMES.keys
  end

  def shift_at
    start_at.on(date)
  end

  def reserved
    reservation.present? && reservation.canceled_at.nil?
  end

  def self.get_shift_increment
    SLOT_INCREMENT_MITUNES.minute
  end

  private

  # 30分刻みでシフトを設定する
  SLOT_INCREMENT_MITUNES = 30

  SHIFT_TIMES = {
    '10:00~10:30' => '10:00:00',
    '10:30~11:00' => '10:30:00',
    '11:00~11:30' => '11:00:00',
    '11:30~12:00' => '11:30:00',
    '12:00~12:30' => '12:00:00',
    '12:30~13:00' => '12:30:00',
    '13:00~13:30' => '13:00:00',
    '13:30~14:00' => '13:30:00',
    '16:00~16:30' => '16:00:00',
    '16:30~17:00' => '16:30:00',
    '17:00~17:30' => '17:00:00',
    '17:30~18:00' => '17:30:00',
    '18:00~18:30' => '18:00:00',
    '18:30~19:00' => '18:30:00',
    '19:00~19:30' => '19:00:00',
    '19:30~20:00' => '19:30:00'
  }.freeze

  def self.shift_of_staff_at_datetime(staff, datetime)
    result = staff.shifts.where(date: datetime).where(start_at: datetime)
    result.count > 0 ? result.first : nil
  end
end
