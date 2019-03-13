class Shift < ApplicationRecord
  require 'csv'
  
  belongs_to :store
  belongs_to :staff

  def self.imports(csv_file)
    csv_rows = CSV.read(csv_file.path, headers: true, encoding: "Shift_JIS:UTF-8")
    @staffs = csv_rows.map { |row|
      self.import(row)
    }
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
end
