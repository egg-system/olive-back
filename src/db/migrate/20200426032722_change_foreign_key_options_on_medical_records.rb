class ChangeForeignKeyOptionsOnMedicalRecords < ActiveRecord::Migration[5.2]
  def change
    # customersレコード削除時に紐づくmedical_recordsも削除するよう修正
    remove_foreign_key :medical_records, :customers
    add_foreign_key :medical_records, :customers, on_delete: :cascade

    # medical_records削除時に子レコードも削除するよう修正
    remove_foreign_key :medical_records_treat_goals, :medical_records
    add_foreign_key :medical_records_treat_goals, :medical_records, on_delete: :cascade

    remove_foreign_key :medical_records_hope_menus, :medical_records
    add_foreign_key :medical_records_hope_menus, :medical_records, on_delete: :cascade

    remove_foreign_key :medical_records_current_hospitals, :medical_records
    add_foreign_key :medical_records_current_hospitals, :medical_records, on_delete: :cascade
  end
end
