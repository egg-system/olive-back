class CreateObseravations < ActiveRecord::Migration[5.2]
  def change
    create_table :obseravations do |t|
      t.references :store, foreign_key: { on_delete: :cascade }, comment: '店舗ID'
      t.date :visit_date, comment: '来院日'
      t.integer :operation_time, comment: '施術時間（分）'
      t.references :staff, foreign_key: { on_delete: :cascade }, comment: '対応したスタッフID'
      t.references :menu, foreign_key: { on_delete: :nullify }, comment: 'メニューID ※ square連携後に廃止'
      t.string :option_ids, comment: '複数のオプションIDをカンマ区切りで文字列にしたもの ※ square連携後に廃止'
      t.string :merchandise, comment: '商品 ※ square連携後に廃止'
      t.text :observation_history, comment: '経過履歴'
      t.string :coupon_name, comment: '回数券名称 ※ square連携後に廃止'
      t.integer :coupon_count, comment: '回数券残 ※ square連携後に廃止'
      t.string :op_coupon_name, comment: 'OP回数券名称 ※ square連携後に廃止'
      t.integer :op_coupon_count, comment: 'OP回数券残 ※ square連携後に廃止'

      t.timestamps
    end
  end
end
