class CreateVisitReasons < ActiveRecord::Migration[5.2]
  def change
    create_table :visit_reasons do |t|
      t.string :name

      t.timestamps
    end
  end
end
