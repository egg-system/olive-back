class CreateStoreTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :store_types do |t|
      t.integer :store_type_id
      t.string :name

      t.timestamps
    end
  end
end
