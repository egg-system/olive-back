class CreateReservationDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_details do |t|
      t.integer :menu_id

      t.timestamps
    end
  end
end
