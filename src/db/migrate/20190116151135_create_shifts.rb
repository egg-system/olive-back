class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts, comment: 'シフト。スタッフと既存の予約の組み合わせで、予約枠になる' do |t|
      t.date :date, comment: 'シフトの日時'

      t.time :start_at, comment: 'シフトの開始時間'
      t.time :end_at, comment: 'シフトの終了時間。30分単位になる'
      
      t.references :store, foreign_key: { on_delete: :cascade }
      t.references :staff, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
