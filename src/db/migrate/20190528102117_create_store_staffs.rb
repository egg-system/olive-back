class CreateStoreStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :store_staffs do |t|
      t.references :store, foreign_key: true
      t.references :staff, foreign_key: true
      
      t.timestamps
    end
  end
end
