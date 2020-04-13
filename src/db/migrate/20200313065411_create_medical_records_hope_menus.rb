class CreateMedicalRecordsHopeMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_records_hope_menus do |t|
      t.references :medical_record, foreign_key: true
      t.references :hope_menu, foreign_key: true
      t.timestamps
    end
  end
end
