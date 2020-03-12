class CreateGoalTherapies < ActiveRecord::Migration[5.2]
  def change
    create_table :goal_therapies do |t|

      t.timestamps
    end
  end
end
