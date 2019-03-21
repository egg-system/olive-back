class AddCustomersForignKeys < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :occupation, foreign_key: true, default: nil, null: true, comment: '職業'
    add_reference :customers, :zoomancy, foreign_key: true, default: nil, null: true, comment: '動物占いの結果'
    add_reference :customers, :baby_age, foreign_key: true, default: nil, null: true, comment: '赤ちゃんの年齢'
    add_reference :customers, :size, foreign_key: true, default: nil, null: true, comment: 'サイズ'
    add_reference :customers, :visit_reason, foreign_key: true, default: nil, null: true, comment: '来店経緯'
    add_reference :customers, :nearest_station, foreign_key: true, default: nil, null: true, comment: '最寄り駅'
  end
end
