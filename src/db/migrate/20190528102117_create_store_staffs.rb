class CreateStoreStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :store_staffs do |t|
      t.references :store, foreign_key: { on_delete: :cascade }
      t.references :staff, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
