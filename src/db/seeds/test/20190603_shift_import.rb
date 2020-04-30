require('csv')

CSV.read(
  Rails.root.join("storage/test/csv/test_import_shift.csv"),
  headers: true, encoding:
  'Shift_JIS:UTF-8'
).map do |row|
  Shift.import(row)
end
