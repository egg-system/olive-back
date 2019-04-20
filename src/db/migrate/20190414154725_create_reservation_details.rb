class CreateReservationDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_details, comment: '予約の詳細。シフトやメニューなどに紐づく' do |t|
      t.references :reservation, on_delete: :cascade, foreign_key: true
      t.references :menu, on_delete: :nullify, foreign_key: true
      t.integer :mimitsubo_count, comment: '耳つぼジュエリの個数。'

      t.timestamps
    end
  end
end
