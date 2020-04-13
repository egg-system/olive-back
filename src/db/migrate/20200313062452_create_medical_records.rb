class CreateMedicalRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_records do |t|
      t.text :pain, comment: 'おつらい症状'
      t.text :current_sickness, comment: '現在煩われている病気'
      t.text :past_sickness, comment: '過去の入院・ケガ・病気・症状・期間'
      t.boolean :right_hand, comment: '利き手'
      t.references :many_posture, foreign_key: true, default: nil, nul: true, comment: '多い姿勢'
      t.references :pregnancy, foreign_key: true, default: nil, nul: true, comment: '妊娠'
      t.references :drinking, foreign_key: true, default: nil, nul: true, comment: '飲酒'
      t.references :cigarette, foreign_key: true, default: nil, nul: true, comment: 'タバコ'
      t.references :massage, foreign_key: true, default: nil, nul: true, comment: '希望の治療'
      t.references :exercise, foreign_key: true, default: nil, nul: true, comment: '運動'
      t.references :customer, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
