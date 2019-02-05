class CreateDepartmentCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :department_categories do |t|
      t.integer :department_id
      t.text :name

      t.timestamps
    end
  end
end
