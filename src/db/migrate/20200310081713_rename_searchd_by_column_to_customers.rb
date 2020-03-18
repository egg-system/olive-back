class RenameSearchdByColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :searchd_by, :searched_by
    change_column_comment :customers, :searched_by, 'web検索単語など'
  end
end
