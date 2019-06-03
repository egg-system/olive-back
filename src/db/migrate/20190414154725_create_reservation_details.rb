class CreateReservationDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_details, comment: '予約の詳細。シフトやメニューなどに紐づく' do |t|
      t.references :reservation, foreign_key: { on_delete: :cascade }
      t.references :menu, foreign_key: { on_delete: :nullify }
      t.integer :mimitsubo_count, default: 0, nil: false, comment: '耳つぼジュエリの個数。デフォルト値はオプションが選択されていて、個数がnilの場合を防ぐため'
      t.timestamps
    end
  end
end
