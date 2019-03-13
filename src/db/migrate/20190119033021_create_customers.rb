class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :first_kana
      t.string :last_kana
      t.string :tel
      t.string :pc_mail
      t.string :phone_mail
      t.boolean :can_receive_mail
      t.date :birthday
      t.string :zip_code
      t.string :prefecture
      t.text :city
      t.text :address
      t.boolean :has_membership
      t.text :comment
      t.references :first_visit_store, foreign_key: { to_table: :stores }
      t.references :last_visit_store, foreign_key: { to_table: :stores }
      t.date :first_visited_at
      t.date :last_visited_at
      t.string :card_number, comment: 'カルテの番号。紙媒体で管理しているため、外部キーなし'
      t.string :introducer, comment: '紹介していただいた方の名前など'
      t.string :searchd_by, comment: 'web検索単語など'
      t.boolean :has_registration_card, comment: '診察券を発行したかどうか'

      t.timestamps
    end
  end
end
