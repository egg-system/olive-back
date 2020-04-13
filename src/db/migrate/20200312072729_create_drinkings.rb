class CreateDrinkings < ActiveRecord::Migration[5.2]
  def change
    create_table :drinkings do |t|
      t.string :name
      t.timestamps
    end
  end
end
