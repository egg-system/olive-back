class CreateOptionMenuCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :option_menu_categories do |t|
      t.references :option, null: false, foreign_key: true
      t.references :menu_category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
