class CreateStoreOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :store_options do |t|
      t.references :store, foreign_key: true
      t.references :option, foreign_key: true
      
      t.timestamps
    end
  end
end
