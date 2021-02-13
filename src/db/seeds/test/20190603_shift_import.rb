require('csv')
require('fileutils')

file_name = "test_import_shift.csv"
FileUtils.mv(Rails.root.join('storage', 'test', 'csv', file_name), Shift.save_csv_path('test_import_shift.csv'))

Shift.import(file_name)