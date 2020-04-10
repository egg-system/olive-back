class CreateManyPostures < ActiveRecord::Migration[5.2]
  def change
    create_table :many_postures do |t|
      t.string :name
      t.timestamps
    end
  end
end
