class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.integer :role_id
      t.string :name

      t.timestamps
    end
  end
end
