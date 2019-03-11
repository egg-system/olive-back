class CreateTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :taxes do |t|
      t.float :rate
      t.timestamps
    end
  end
end
