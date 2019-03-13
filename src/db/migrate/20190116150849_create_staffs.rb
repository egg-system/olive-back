class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.string :first_name
      t.string :last_name
      t.string :first_kana
      t.string :last_kana
      t.references :store, foreign_key: true, null: false
      t.integer :employment_type, comment: 'model内でenumにする。0:正社員, 1:契約社員, 2:パート・アルバイト'
      t.datetime :deleted_at
      t.boolean :is_absenced
      t.timestamps
    end
  end
end
