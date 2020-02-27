class CreateCustomerSales < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_sales do |t|
      t.references :customer, foreign_key: { on_delete: :cascade } 
      t.integer :total_sales, comment: '売上総額'

      t.timestamps
    end
  end
end
