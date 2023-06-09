class AddDeleteOnCascadeToStoreOptions < ActiveRecord::Migration[5.2]
  def up
    remove_foreign_key :store_options, :options
    add_foreign_key :store_options, :options, on_delete: :cascade
    remove_foreign_key :store_options, :stores
    add_foreign_key :store_options, :stores, on_delete: :cascade
  end

  def down
    remove_foreign_key :store_options, :options
    add_foreign_key :store_options, :options
    remove_foreign_key :store_options, :stores
    add_foreign_key :store_options, :stores
  end
end
