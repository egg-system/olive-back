class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.integer :shift_id
      t.date :shift_date
      t.integer :store_id
      t.integer :staff_id
      t.time :shift_begin
      t.time :shift_end
      t.boolean :time_1011
      t.boolean :time_1011
      t.boolean :time_1112
      t.boolean :time_1213
      t.boolean :time_1314
      t.boolean :time_1415
      t.boolean :time_1516
      t.boolean :time_1617
      t.boolean :time_1718
      t.boolean :time_1819
      t.boolean :time_1920

      t.timestamps
    end
  end
end
