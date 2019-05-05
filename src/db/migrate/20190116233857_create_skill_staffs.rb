class CreateSkillStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_staffs do |t|
      t.references :staff, foreign_key: { on_delete: :cascade }
      t.references :skill, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end
