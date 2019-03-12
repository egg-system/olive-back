class CreateSkillsMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :skills_menus do |t|
      t.references :skill, foreign_key: true
      t.references :menu, foreign_key: true
      t.timestamps
    end
  end
end
