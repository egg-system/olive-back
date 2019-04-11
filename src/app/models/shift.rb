class Shift < ApplicationRecord
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

  def self.to_time_slot
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
      Shift.where(
        store_id: store_id, 
        staff_id: staff_id,
        date: shift_date, 
        shift_time: SHIFT_TIMES[key]
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
    shift_date = DateTime.parse("#{date_string} #{self.shift_time}")
    shift_date.strftime('%Y%m%d%H')
  end

  private

  SHIFT_TIMES = {
    '10:00~11:00' => '10:00:00',
    '11:00~12:00' => '11:00:00',
    '12:00~13:00' => '12:00:00',
    '13:00~14:00' => '13:00:00',
    '14:00~15:00' => '13:00:00',
    '15:00~16:00' => '13:00:00',
    '16:00~17:00' => '16:00:00',
    '17:00~18:00' => '17:00:00', 
    '18:00~19:00' => '18:00:00', 
    '19:00~20:00' => '19:00:00', 
  }
end
