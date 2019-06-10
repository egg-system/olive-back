class AddIsConfirmedColumnToReservations < ActiveRecord::Migration[5.2]
  def up
    add_column :reservations, :is_confirmed, :boolean, comment: '担当者が確認したかどうかの目印を保持する'
  end

  def down
    remove_column :reservations, :is_confirmed, :boolean
  end
end
