class CreateMedicalRecordsCurrentHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_records_current_hospitals do |t|
      t.references :medical_record, foreign_key: true
      t.references :current_hospital, foreign_key: true
      t.timestamps
    end
  end
end
