class CreateObservations < ActiveRecord::Migration[5.2]
  def change
    create_table :observations do |t|
      t.references :store, foreign_key: { on_delete: :cascade }, comment: '店舗ID'
      t.datetime :visit_datetime, comment: '来院日時（開始時刻）'
      t.references :staff, foreign_key: { on_delete: :cascade }, comment: '対応したスタッフID'
      t.references :menu, foreign_key: { on_delete: :nullify }, comment: 'メニューID ※ square連携後に廃止'
      t.string :option_ids, comment: '複数のオプションIDをカンマ区切りで文字列にしたもの ※ square連携後に廃止'
      t.text :merchandise, comment: '商品 ※ square連携後に廃止'
      t.text :observation_history, comment: '経過履歴'
      t.integer :coupon_count, comment: '回数券残'
      t.integer :op_coupon_count, comment: 'OP回数券残'

      t.timestamps
    end
  end
end
