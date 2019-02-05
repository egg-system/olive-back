class CreatePregnantStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :pregnant_statuses do |t|
      t.integer :pregnant_status_id
      t.text :name

      t.timestamps
    end
  end
end
