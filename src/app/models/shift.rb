class Shift < ApplicationRecord
  require 'tod'

  serialize :start_at, Tod::TimeOfDay
  serialize :end_at, Tod::TimeOfDay

  extend DateModule

  has_many :reservations
  
  belongs_to :store
  belongs_to :staff

  scope :where_months, -> (start_month, end_month = nil) {
    start_date, end_date = get_month_range(start_month, end_month)
    where(date: (start_date)..(end_date))
  }

  scope :has_any_reservation, -> {
    left_joins(:reservations).where('reservations.id is NULL')
  }

  def self.to_time_slots
    return all.group_by { |shift| 
      shift.date 
    }.map { |date, shifts|
      time_slots = shifts.group_by { |shift|
        shift.shift_at
      }.map { |shift_at, shift_group|
        { start_time: shift_at, remain: shift_group.count }
      }

      { date: date, time_slots: time_slots }
    }
  end
  
  def self.import(csv_row)
    shift_date = "#{csv_row['年月']}-#{csv_row['日']}"
    store_id = csv_row['店舗ID']
    staff_id = csv_row['スタッフID']

    csv_row.select { |key, value|
      SHIFT_TIMES.has_key?(key) && value === '1'
    }.each { |key, value|
      shift_time = Tod::TimeOfDay.parse(SHIFT_TIMES[key])
      shift = Shift.where(
        store_id: store_id, 
        staff_id: staff_id,
        date: shift_date, 
        start_at: shift_time,
        end_at: shift_time + SLOT_INCREMENT_SECOND,
      ).first_or_create()
    }
  end

  def self.get_time_slots(date)
    SHIFT_TIMES.map { |label, time_slot| 
      DateTime.parse("#{date} #{time_slot}")
    }
  end

  def shift_at
    date_string = self.date.strftime('%Y-%m-%d')
    shift_date = DateTime.parse("#{date_string} #{self.start_at}")
    shift_date.strftime('%Y%m%d%H%M')
  end

  def self.slot_time_labels
    return SHIFT_TIMES.keys
  end

  private
  # 30分刻みでシフトを設定する
  SLOT_INCREMENT_SECOND = 1800

  SHIFT_TIMES = {
    '10:00~10:30'  => '10:00:00',
    '10:30~11:00'  => '10:30:00',
    '11:00~11:30'  => '11:00:00',
    '11:30~12:00'  => '11:30:00',
    '12:00~12:30'  => '12:00:00',
    '12:30~13:00'  => '12:30:00',
    '13:00~13:30'  => '13:00:00',
    '13:30~14:00'  => '13:30:00',
    '16:00~16:30'  => '16:00:00',
    '16:30~17:00'  => '16:30:00',
    '17:00~17:30'  => '17:00:00',
    '17:30~18:00'  => '17:30:00',
    '18:00~18:30'  => '18:00:00',
    '18:30~19:00'  => '18:30:00',
    '19:00~19:30'  => '19:00:00',
    '19:30~20:00'  => '19:30:00',
  }
end
