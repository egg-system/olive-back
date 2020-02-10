class AddIsDeletedToCustomers < ActiveRecord::Migration[5.2]
  def up
    add_column(
      :customers,
      :is_deleted,
      :boolean,
      default: false,
      comment: '
        使用していない顧客に対し、trueにする。
        いわゆる論理削除とは異なり、ユーザー側で値を変更する。
        バグなどの原因になりうるため、システム側で特殊な処理は実施しない。
      '
    )
  end

  def down
    remove_column :customers, :is_deleted, :boolean
  end
end
