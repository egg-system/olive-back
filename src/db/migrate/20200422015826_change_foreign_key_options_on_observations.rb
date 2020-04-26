class ChangeForeignKeyOptionsOnObservations < ActiveRecord::Migration[5.2]
  def change
    #店舗、スタッフ削除時に経過記録まで削除する必要はないので、on deleteの設定をnullifyに修正。
    remove_foreign_key :observations, :stores
    add_foreign_key :observations, :stores, on_delete: :nullify

    remove_foreign_key :observations, :staffs
    add_foreign_key :observations, :staffs, on_delete: :nullify
  end
end
