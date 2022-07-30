class CreateNearStoreOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :near_store_options do |t|
      t.references :store, null: false
      t.references :near_store, null: false

      t.timestamps
    end
    add_foreign_key :near_store_options, :stores, column: :store_id
    add_foreign_key :near_store_options, :stores, column: :near_store_id
  end
end
