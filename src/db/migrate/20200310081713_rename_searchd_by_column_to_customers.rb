class RenameSearchdByColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :searchd_by, :searched_by
  end
end
