class CreateReservationDetailOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_detail_options do |t|
      t.references :reservation_detail, foreign_key: { on_delete: :cascade }
      t.references :option, foreign_key: { on_delete: :nullify }

      t.timestamps
    end
  end
end
