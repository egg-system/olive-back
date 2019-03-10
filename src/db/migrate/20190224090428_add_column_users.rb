class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :staff, foreign_key: true
    add_reference :users, :role, foreign_key: true
  end
end
