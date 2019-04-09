class Shift < ApplicationRecord
  extend DateModule
  
  belongs_to :store
  belongs_to :staff

  def self.to_month_slots(start_month, end_month = nil)
    start_date, end_date = get_month_range(start_month, end_month)
    to_time_slots(start_date, end_date)
  end

  def self.to_date_slot(shifts)
    date_slot = {
      date: shifts.first().date
    }

    DATE_ATTRIBUTES.each { |date_attribute|
      date_count = shifts.count { |shift|
        shift.attributes[date_attribute.to_s]
      }

      date_slot[date_attribute] = date_count
    }

    return date_slot
  end

  def self.to_time_slots(start_date, end_date)
    shifts = where(date: (start_date)..(end_date))

    # 日付で配列にして返す
    return (start_date..end_date).map { |date|
      date_shifts = shifts.select { |shift| 
        isSameDay(shift.date, Date.parse(date)) 
      }

      if date_shifts.empty?
        date_shifts = Array(self.new(date: date))
      end

      date_shifts
    }
  end
  
  def self.import(csv_row)
    shift_keys = {
      date: "#{csv_row['年月']}-#{csv_row['日']}",
      store_id: csv_row['店舗ID'],
      staff_id: csv_row['スタッフID']
    }

    shift = Shift.where(shift_keys).first_or_create() 
    shift.update!(csv_row.select { |key, value|
      CSV_HEADER.has_key?(key)
    }.map { |key, value|
      [CSV_HEADER[key], value]
    }.to_h)
  end

  private

  CSV_HEADER = {
    '10:00~11:00' => :on_shift_10_to_11,
    '11:00~12:00' => :on_shift_11_to_12,
    '12:00~13:00' => :on_shift_12_to_13,
    '13:00~14:00' => :on_shift_13_to_14,
    '16:00~17:00' => :on_shift_16_to_17,
    '17:00~18:00' => :on_shift_17_to_18, 
    '18:00~19:00' => :on_shift_18_to_19, 
    '19:00~20:00' => :on_shift_19_to_20, 
  }

  DATE_ATTRIBUTES = [
    :on_shift_10_to_11,
    :on_shift_11_to_12,
    :on_shift_12_to_13,
    :on_shift_13_to_14,
    :on_shift_14_to_15,
    :on_shift_15_to_16,
    :on_shift_16_to_17,
    :on_shift_17_to_18, 
    :on_shift_18_to_19, 
    :on_shift_19_to_20, 
  ]
end
