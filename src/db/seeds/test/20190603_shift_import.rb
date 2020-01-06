require('csv')

CSV.read(
  Rails.root.join("storage/test/csv/test_import_shift.csv"), 
  headers: true, encoding: 
  'Shift_JIS:UTF-8'
).map { |row|
  Shift.import(row)
}