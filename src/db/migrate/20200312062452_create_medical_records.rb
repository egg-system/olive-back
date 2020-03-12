class CreateMedicalRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_records do |t|
      t.text :pain, comment: 'おつらい症状'
      t.text :current_sickness, comment: '現在煩われている病気'
      t.text :past_sickness, comment: '過去の入院・ケガ・病気・症状・期間'
      t.boolean :right_hand, comment: '利き手'

      t.timestamps
    end
  end
end
