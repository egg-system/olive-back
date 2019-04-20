class CreateReservationDetailOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_detail_options do |t|
      t.references :reservation_detail, on_delete: :cascade, foreign_key: true
      t.references :option, on_delete: :nullify, foreign_key: true

      t.timestamps
    end
  end
end
