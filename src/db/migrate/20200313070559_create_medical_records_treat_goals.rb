class CreateMedicalRecordsTreatGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_records_treat_goals do |t|
      t.references :medical_record, foreign_key: true
      t.references :treat_goal, foreign_key: true
      t.timestamps
    end
  end
end
