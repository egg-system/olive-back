class AddTotalSalesToCustomers < ActiveRecord::Migration[5.2]
  def up
    add_column :customers, :total_payment, :integer, default: 0, comment: 'FMに登録されている売上の合計額を移行した項目。新規ユーザーは0になる見込み'
  end

  def down
    remove_column :customers, :total_payment, :integer
  end
end
