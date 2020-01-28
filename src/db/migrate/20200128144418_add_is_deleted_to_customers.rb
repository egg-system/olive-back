class AddIsDeletedToCustomers < ActiveRecord::Migration[5.2]
  def up
    add_column :customers, :is_deleted, :boolean, default: false, comment: '削除フラグ'
  end

  def down
    remove_column :customers, :is_deleted, :boolean
  end
end
