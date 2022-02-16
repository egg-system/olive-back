class Shift < ApplicationRecord

  # time型を扱いやすくするための実装
  attribute :start_at, :time_only
  attribute :end_at, :time_only

  extend DateModule

  has_one :reservation_shift
  has_one :reservation, through: :reservation_shift

  belongs_to :store
  belongs_to :staff

  scope :where_months, ->(start_month, end_month = nil) {
    start_date, end_date = get_month_range(start_month, end_month)
    where(date: (start_date)..(end_date))
  }

  scope :where_not_reserved, -> {
    left_joins(:reservation).where('reservations.id is NULL')
  }

  def self.to_time_slots
    date_shift_groups = all.group_by { |shift| shift.date }
    return date_shift_groups.map { |date, shifts|
      time_shift_groups = shifts.group_by { |shift|
        shift.shift_at
      }
      time_slots = time_shift_groups.map { |shift_at, shift_group|
        {
          start_time: shift_at,
          staff_ids: shift_group.map { |shift| shift.staff_id },
        }
      }

      [date.strftime('%Y%m%d'), time_slots]
    }.to_h
  end

  def self.parse(csv_row)
    shift_date = "#{csv_row['年月']}-#{csv_row['日']}"
    store_id = csv_row['店舗ID']
    staff_id = csv_row['スタッフID']

    csv_row.select { |key, value|
      SHIFT_TIMES.has_key?(key) && value === '1'
    }.map { |key, value|
      shift_time = Tod::TimeOfDay.parse(SHIFT_TIMES[key])
      {
        store_id: store_id,
        staff_id: staff_id,
        date: shift_date,
        start_at: shift_time,
        end_at: shift_time + SLOT_INCREMENT_MITUNES.minutes
      }
    }.filter { |shift_data|
      Shift.new(shift_data).valid?
    }
  end

  def self.save_csv_path(file_name)
    Rails.root.join('storage', 'csv', file_name)
  end

  def self.slot_times
    return SHIFT_TIMES
  end

  def self.display_slot_times
    return DISPLAY_SHIFT_TIMES
  end

  def shift_at
    self.start_at.on(self.date)
  end

  def reserved
    return self.reservation.present? && self.reservation.canceled_at.nil?
  end

  def self.get_shift_increment
    return SLOT_INCREMENT_MITUNES.minute
  end

  private

  # 30分刻みでシフトを設定する
  SLOT_INCREMENT_MITUNES = 30

  SHIFT_TIMES = {
    '09:00~09:30' => '09:00:00',
    '09:30~10:00' => '09:30:00',
    '10:00~10:30' => '10:00:00',
    '10:30~11:00' => '10:30:00',
    '11:00~11:30' => '11:00:00',
    '11:30~12:00' => '11:30:00',
    '12:00~12:30' => '12:00:00',
    '12:30~13:00' => '12:30:00',
    '13:00~13:30' => '13:00:00',
    '13:30~14:00' => '13:30:00',
    '14:00~14:30' => '14:00:00',
    '14:30~15:00' => '14:30:00',
    '15:00~15:30' => '15:00:00',
    '15:30~16:00' => '15:30:00',
    '16:00~16:30' => '16:00:00',
    '16:30~17:00' => '16:30:00',
    '17:00~17:30' => '17:00:00',
    '17:30~18:00' => '17:30:00',
    '18:00~18:30' => '18:00:00',
    '18:30~19:00' => '18:30:00',
    '19:00~19:30' => '19:00:00',
    '19:30~20:00' => '19:30:00',
  }

  DISPLAY_SHIFT_TIMES = {
    '09:00~10:00' => '09:00:00',
    '10:00〜11:00' => '10:00:00',
    '11:00〜12:00' => '11:00:00',
    '12:00〜13:00' => '12:00:00',
    '13:00〜14:00' => '13:00:00',
    '14:00〜15:00' => '14:00:00',
    '15:00〜16:00' => '15:00:00',
    '16:00〜17:00' => '16:00:00',
    '17:00〜18:00' => '17:00:00',
    '18:00〜19:00' => '18:00:00',
    '19:00〜20:00' => '19:00:00'
  }

  def self.shift_of_staff_at_datetime(staff, datetime)
    result = staff.shifts.where(date: datetime).where(start_at: datetime)
    return 0 < result.count ? result.first : nil
  end
end
