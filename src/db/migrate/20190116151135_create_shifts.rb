class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.date :date
      t.references :store, foreign_key: true
      t.references :staff, foreign_key: true
      t.boolean :on_shift_10_to_11, comment: '10時~11時に施術可能か'
      t.boolean :on_shift_11_to_12, comment: '11時~12時に施術可能か'
      t.boolean :on_shift_12_to_13, comment: '12時~13時に施術可能か'
      t.boolean :on_shift_13_to_14, comment: '13時~14時に施術可能か'
      t.boolean :on_shift_14_to_15, comment: '14時~15時に施術可能か'
      t.boolean :on_shift_15_to_16, comment: '15時~16時に施術可能か'
      t.boolean :on_shift_16_to_17, comment: '16時~17時に施術可能か'
      t.boolean :on_shift_17_to_18, comment: '17時~18時に施術可能か'
      t.boolean :on_shift_18_to_19, comment: '18時~19時に施術可能か'
      t.boolean :on_shift_19_to_20, comment: '19時~20時に施術可能か'

      t.timestamps
    end
  end
end
