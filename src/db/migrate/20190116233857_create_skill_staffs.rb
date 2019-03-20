class CreateSkillStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_staffs do |t|
      t.references :staff, foreign_key: true
      t.references :skill, foreign_key: true
      t.timestamps
    end
  end
end
