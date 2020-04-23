class ChangeForeignKeyOptionsOnObservations < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :observations, :stores
    add_foreign_key :observations, :stores, on_delete: :nullify

    remove_foreign_key :observations, :staffs
    add_foreign_key :observations, :staffs, on_delete: :nullify
  end
end
