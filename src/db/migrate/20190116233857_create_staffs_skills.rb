class CreateStaffsSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs_skills do |t|
      t.integer :staff_skill_id
      t.integer :staff_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
