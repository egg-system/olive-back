class CreateSkillStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_staffs do |t|
      t.references :staff, on_delete: :cascade, foreign_key: true
      t.references :skill, on_delete: :cascade, foreign_key: true
      t.timestamps
    end
  end
end
