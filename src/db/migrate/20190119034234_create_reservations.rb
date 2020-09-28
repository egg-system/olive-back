class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer :children_count, default: 0, comment: '随伴するお子様の数'
      t.text :reservation_comment

      t.references :store, foreign_key: { on_delete: :cascade }
      t.references :staff, foreign_key: { on_delete: :cascade }, comment: '対応予定のスタッフid。キャンセル時にシフトとのリレーションを消すため、追加'
      t.references :customer, foreign_key: { on_delete: :cascade }

      t.date :reservation_date
      t.time :start_time
      t.time :end_time

      t.boolean :is_first
      t.datetime :canceled_at, comment: 'キャンセルされた日時'
      t.timestamps
    end
  end
end
