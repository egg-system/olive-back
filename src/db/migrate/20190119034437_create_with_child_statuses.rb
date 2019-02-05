class CreateWithChildStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :with_child_statuses do |t|
      t.integer :with_child_status_id
      t.text :name

      t.timestamps
    end
  end
end
