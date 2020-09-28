class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :first_kana
      t.string :last_kana
      t.string :tel, comment: '携帯電話番号'
      t.string :fixed_line_tel, comment: '固定電話番号'
      t.string :gender, comment: "性別"
      t.boolean :can_receive_mail, nil: false, default: true, comment: 'お知らせメールなどの受け取り可否'
      t.boolean :is_receive_thank_you_letter, default: false, comment: "サンキューレター送付済みかどうか"
      t.boolean :can_receive_dm_mail, default: true, comment: "DM配信受け取り可否"
      t.date :birthday
      t.string :zip_code
      t.string :prefecture
      t.text :city
      t.text :address
      t.text :comment
      t.references :first_visit_store, nil: true, foreign_key: { to_table: :stores }
      t.references :last_visit_store, nil: true, foreign_key: { to_table: :stores }
      t.date :first_visited_at
      t.date :last_visited_at
      t.string :card_number, comment: 'カルテの番号。紙媒体で管理しているため、外部キーなし'
      t.string :introducer, comment: '紹介していただいた方の名前など'
      t.string :searchd_by, comment: 'web検索単語など'
      t.boolean :has_registration_card, comment: '診察券を発行したかどうか'
      t.integer :children_count, null: true, comment: 'お子様の数。その他やdefault値にあたるものはnullにする'

      t.timestamps
    end
  end
end
