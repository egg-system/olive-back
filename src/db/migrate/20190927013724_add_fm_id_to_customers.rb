class AddFmIdToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :fmid, :integer
  end
end
