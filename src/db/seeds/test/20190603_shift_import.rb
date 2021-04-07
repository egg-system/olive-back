require('csv')
require('fileutils')

file_name = "test_import_shift.csv"
FileUtils.cp(Rails.root.join('storage', 'test', 'csv', file_name), Shift.save_csv_path('test_import_shift.csv'))

CSV.read(Shift.save_csv_path(file_name), headers: true, encoding: "Shift_JIS:UTF-8").flat_map do |row|
  Shift.parse(row).map do |shift_data|
    Shift.where(shift_data).first_or_create
  end
end