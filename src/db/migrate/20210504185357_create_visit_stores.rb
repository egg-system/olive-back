class CreateVisitStores < ActiveRecord::Migration[5.2]
  def change
    create_table :visit_stores do |t|
      t.references :store, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
