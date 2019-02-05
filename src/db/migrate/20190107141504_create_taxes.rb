class CreateTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :taxes do |t|
      t.integer :tax_id
      t.float :tax_rate
      t.boolean :tax_flg

      t.timestamps
    end
  end
end
