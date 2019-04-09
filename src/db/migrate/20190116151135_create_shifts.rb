class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts, comment: 'シフト。スタッフと既存の予約の組み合わせで、予約枠になる' do |t|
      t.date :date, comment: 'シフトの日時'
      t.string :shift_time, comment: 'シフトの時間帯。1時間単位になる'
      
      t.references :store, foreign_key: true
      t.references :staff, foreign_key: true

      t.timestamps
    end
  end
end
