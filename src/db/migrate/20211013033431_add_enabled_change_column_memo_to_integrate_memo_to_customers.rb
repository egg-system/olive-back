class AddEnabledChangeColumnMemoToIntegrateMemoToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :enabled, :boolean, null: false, default: true
    rename_column :customers, :memo, :integrate_memo
  end
end
