class CreateObseravations < ActiveRecord::Migration[5.2]
  def change
    create_table :obseravations do |t|
      t.references :store, foreign_key: { on_delete: :cascade }, comment: '店舗ID'
      t.datetime :visit_datetime, comment: '来院日時（開始時刻）'
      t.references :staff, foreign_key: { on_delete: :cascade }, comment: '対応したスタッフID'
      t.references :menu, foreign_key: { on_delete: :nullify }, comment: 'メニューID ※ square連携後に廃止'
      t.string :option_ids, comment: '複数のオプションIDをカンマ区切りで文字列にしたもの ※ square連携後に廃止'
      t.text :merchandise, comment: '商品 ※ square連携後に廃止'
      t.text :observation_history, comment: '経過履歴'
      t.references :coupon, foreign_key: { to_table: :coupons, on_delete: :nullify }, comment: '回数券ID'
      t.integer :coupon_count, comment: '回数券残'
      t.references :op_coupon, foreign_key: { to_table: :op_coupon, on_delete: :nullify }, comment: 'OP回数券ID'
      t.integer :op_coupon_count, comment: 'OP回数券残'

      t.timestamps
    end
  end
end
