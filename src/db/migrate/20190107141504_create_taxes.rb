class CreateTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :taxes do |t|
      t.float :rate
      t.boolean :is_default, comment: 'このフラグが立っている税率がデフォルトになる'
      t.timestamps
    end
  end
end
