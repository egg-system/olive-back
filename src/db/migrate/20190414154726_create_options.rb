class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.string :name
      t.references :skill, foreign_key: true
      t.references :department, foreign_key: true
      t.text :description
      t.integer :fee
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
