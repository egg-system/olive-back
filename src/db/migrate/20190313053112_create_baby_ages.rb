class CreateBabyAges < ActiveRecord::Migration[5.2]
  def change
    create_table :baby_ages do |t|
      t.string
      t.timestamps
    end
  end
end