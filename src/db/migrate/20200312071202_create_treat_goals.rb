class CreateTreatGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :treat_goals do |t|
      t.string :name
      t.timestamps
    end
  end
end
