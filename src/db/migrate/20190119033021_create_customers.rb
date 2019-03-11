class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :first_kana
      t.string :last_kana
      t.string :tel
      t.string :mail, comment: 'メールアドレス'
      t.boolean :can_receive_mail
      t.date :birthday
      t.string :zip_code
      t.string :prefecture
      t.text :city
      t.text :address
      t.boolean :has_membership
      t.text :comment
      t.references :fitsrt_visit_store, foreign_key: { to_table: :stores }
      t.references :last_visit_store, foreign_key: { to_table: :stores }
      t.date :last_visited_at

      t.timestamps
    end
  end
end
