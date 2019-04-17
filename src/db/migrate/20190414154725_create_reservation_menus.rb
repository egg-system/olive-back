class CreateReservationMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_menus do |t|
      t.references :reservation, foreign_key: true
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end
