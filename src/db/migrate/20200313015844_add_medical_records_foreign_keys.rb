class AddMedicalRecordsForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_reference :medical_records, :hope_therapy, foreign_key: true, default: nil, nul: true, comment: '希望の治療'
    add_reference :medical_records, :goal_therapy, foreign_key: true, default: nil, nul: true, comment: '治療の目的'
    add_reference :medical_records, :current_hospital, foreign_key: true, default: nil, nul: true, comment: '現在通われている病院'
    add_reference :medical_records, :many_posture, foreign_key: true, default: nil, nul: true, comment: '多い姿勢'
    add_reference :medical_records, :pregnancy, foreign_key: true, default: nil, nul: true, comment: '妊娠'
    add_reference :medical_records, :drinking, foreign_key: true, default: nil, nul: true, comment: '飲酒'
    add_reference :medical_records, :cigarette, foreign_key: true, default: nil, nul: true, comment: 'タバコ'
    add_reference :medical_records, :massage, foreign_key: true, default: nil, nul: true, comment: '希望の治療'
    add_reference :medical_records, :exercise, foreign_key: true, default: nil, nul: true, comment: '運動'
    add_reference :hope_therapies, :hope_therapy_menu, foreign_key: true, default: nil, nul: true, comment: '希望の治療の選択メニュー'
    add_reference :goal_therapies, :goal_therapy_menu, foreign_key: true, default: nil, nul: true, comment: '治療の目的の選択メニュー'
    add_reference :current_hospitals, :current_hospital_menu, foreign_key: true, default: nil, nul: true, comment: '現在通っている病院の選択メニュー'
  end
end
