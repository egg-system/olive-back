class CreateMenuCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_categories do |t|
      t.integer :menu_category_id
      t.string :name
      t.integer :department_id

      t.timestamps
    end
  end
end
