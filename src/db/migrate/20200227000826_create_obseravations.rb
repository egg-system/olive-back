class CreateObseravations < ActiveRecord::Migration[5.2]
  def change
    create_table :obseravations do |t|
      t.references :store, foreign_key: { on_delete: :cascade }, comment: '店舗ID'
      t.date :visit_date, comment: '来院日時'
      t.references :staff, foreign_key: { on_delete: :cascade }, comment: '対応したスタッフID'
      t.references :menu, foreign_key: { on_delete: :nullify }, comment: 'メニューID'
      t.references :option, foreign_key: { on_delete: :nullify }, comment: 'オプションID'
      t.string :merchandise, comment: '商品'
      t.text :observation_history, comment: '経過履歴'
      t.integer :coupon_count, comment: '回数券残'
      t.integer :op_coupon_count, comment: 'OP回数券残'

      t.timestamps
    end
  end
end
