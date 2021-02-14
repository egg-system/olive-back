require('csv')
require('fileutils')

file_name = "test_import_shift.csv"
FileUtils.cp(Rails.root.join('storage', 'test', 'csv', file_name), Shift.save_csv_path('test_import_shift.csv'))

CSV.read(Shift.save_csv_path('test_import_shift.csv'), headers: true, encoding: "Shift_JIS:UTF-8")
   .map { |row| Shift.where(Shift.parse(row)).first_or_create }
