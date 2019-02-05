class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.integer :staff_id
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.integer :staff_skill_id
      t.integer :belong_store_id
      t.integer :role_id
      t.string :employee_type
      t.boolean :absence_flg
      t.boolean :deleted_flg

      t.timestamps
    end
  end
end
